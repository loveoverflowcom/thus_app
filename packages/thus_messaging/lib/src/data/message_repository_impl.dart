import 'dart:convert';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

import '../domain/entities/chat.dart';
import '../domain/entities/message.dart';
import '../domain/entities/message_status.dart';
import 'message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl({
    required RestClient restClient,
    required SseClient sseClient,
    required CacheRepository<Message> cache,
    required AuthRepository authRepository,
    required AppLogger logger,
  }) : _restClient = restClient,
       _sseClient = sseClient,
       _cache = cache,
       _authRepository = authRepository,
       _logger = logger;

  final RestClient _restClient;
  final SseClient _sseClient;
  final CacheRepository<Message> _cache;
  final AuthRepository _authRepository;
  final AppLogger _logger;

  Stream<Message>? _incomingStream;

  @override
  Future<Message> send({
    required String toUserId,
    required String content,
    String source = 'thus_cli',
  }) async {
    final String normalizedToUserId = toUserId.trim();
    if (!isUuid(normalizedToUserId)) {
      throw FormatException(
        'Target user id must be a UUID. Received "$toUserId". '
        'The server does not accept usernames in to_user_id.',
      );
    }

    final AuthSession session = await _requireSession();
    final Message draft = Message(
      id: 'local-${DateTime.now().microsecondsSinceEpoch}',
      senderId: session.userId,
      receiverId: normalizedToUserId,
      timestamp: DateTime.now().toUtc(),
      content: content,
      status: MessageStatus.sending,
      conversationId: normalizedToUserId,
      source: source,
      isIncoming: false,
    );

    await _cache.write(draft.id, draft);

    final Map<String, dynamic>? response = await _restClient.postJson(
      AppConstants.sendMessagePath,
      data: <String, dynamic>{
        'to_user_id': normalizedToUserId,
        'event': draft.eventName,
        'payload': <String, dynamic>{'body': content, 'source': source},
      },
      headers: _bearerHeaders(session.accessToken),
    );

    final int deliveredConnections =
        (response?['delivered_connections'] as num?)?.toInt() ?? 0;
    final int queuedMessages =
        (response?['queued_messages'] as num?)?.toInt() ?? 0;

    final Message persisted = draft.copyWith(
      status: deliveredConnections > 0
          ? MessageStatus.delivered
          : queuedMessages > 0
          ? MessageStatus.sent
          : MessageStatus.sent,
    );

    await _cache.write(persisted.id, persisted);
    return persisted;
  }

  @override
  Stream<Message> incoming() {
    final Stream<Message>? existingStream = _incomingStream;
    if (existingStream != null) {
      return existingStream;
    }

    late final Stream<Message> stream;
    stream = (() async* {
      try {
        yield* _buildIncomingStream();
      } finally {
        if (identical(_incomingStream, stream)) {
          _incomingStream = null;
        }
      }
    })().asBroadcastStream();

    _incomingStream = stream;
    return stream;
  }

  @override
  Future<List<Message>> loadHistory(String conversationId) async {
    final List<Message> cached = await _cache.readAll();
    final List<Message> filtered =
        cached
            .where(
              (Message message) => message.conversationId == conversationId,
            )
            .toList(growable: false)
          ..sort(
            (Message left, Message right) =>
                left.timestamp.compareTo(right.timestamp),
          );

    return filtered;
  }

  @override
  Stream<Message> subscribe(String conversationId) {
    return incoming().where(
      (Message message) => message.conversationId == conversationId,
    );
  }

  @override
  Future<List<Chat>> loadChats() async {
    final List<Message> cached = await _cache.readAll();
    final Map<String, List<Message>> grouped = <String, List<Message>>{};

    for (final Message message in cached) {
      grouped
          .putIfAbsent(message.conversationId, () => <Message>[])
          .add(message);
    }

    final List<Chat> chats =
        grouped.entries
            .map((MapEntry<String, List<Message>> entry) {
              final List<Message> messages = entry.value
                ..sort(
                  (Message left, Message right) =>
                      right.timestamp.compareTo(left.timestamp),
                );
              final Message lastMessage = messages.first;
              return Chat(
                id: entry.key,
                title: entry.key,
                participantIds: <String>[
                  lastMessage.senderId,
                  lastMessage.receiverId,
                ],
                lastMessage: lastMessage,
                updatedAt: lastMessage.timestamp,
              );
            })
            .toList(growable: false)
          ..sort((Chat left, Chat right) {
            final DateTime leftDate =
                left.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final DateTime rightDate =
                right.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return rightDate.compareTo(leftDate);
          });

    return chats;
  }

  Stream<Message> _buildIncomingStream() async* {
    final AuthSession session = await _requireSession();

    await for (final SseEvent event in _sseClient.listen(
      AppConstants.eventsPath,
      headers: _bearerHeaders(session.notificationToken),
    )) {
      final List<Message> messages = _mapSseEventToMessages(
        event: event,
        session: session,
      );

      for (final Message message in messages) {
        final Message stored = await _storeIncomingMessage(message);
        yield stored;
      }
    }
  }

  List<Message> _mapSseEventToMessages({
    required SseEvent event,
    required AuthSession session,
  }) {
    dynamic decoded;

    try {
      decoded = jsonDecode(event.data);
    } on FormatException {
      _logger.log(
        'Ignoring non-JSON SSE event ${event.event}: ${event.data}',
        level: LogLevel.warning,
      );
      return <Message>[];
    }

    final Map<String, dynamic>? decodedMap = _castJsonMap(decoded);
    if (event.event == 'system.ready' && decodedMap != null) {
      final Object? rawReplayedMessages = decodedMap['replayed_messages'];
      final List<dynamic>? replayed = _castJsonList(rawReplayedMessages);
      if (rawReplayedMessages != null && replayed == null) {
        _logger.log(
          'Ignoring system.ready replayed_messages with unexpected type '
          '${rawReplayedMessages.runtimeType}.',
          level: LogLevel.warning,
        );
        return <Message>[];
      }

      return (replayed ?? const <dynamic>[])
          .map(
            (dynamic raw) => _mapPayloadToMessage(
              raw: raw,
              fallbackEventName: 'chat.message',
              session: session,
            ),
          )
          .whereType<Message>()
          .toList(growable: false);
    }

    final Message? message = _mapPayloadToMessage(
      raw: decoded,
      fallbackEventName: event.event,
      session: session,
      remoteEventId: event.id,
    );
    if (message == null) {
      return <Message>[];
    }

    return <Message>[message];
  }

  Message? _mapPayloadToMessage({
    required dynamic raw,
    required String fallbackEventName,
    required AuthSession session,
    String? remoteEventId,
  }) {
    final Map<String, dynamic>? payloadMap = _castJsonMap(raw);
    if (payloadMap == null) {
      return null;
    }

    final Map<String, dynamic> nestedPayload =
        _castJsonMap(payloadMap['payload']) ?? <String, dynamic>{};
    final String? content =
        _stringValue(nestedPayload['body']) ??
        _stringValue(payloadMap['body']) ??
        _stringValue(payloadMap['message']);

    if (content == null || content.trim().isEmpty) {
      return null;
    }

    final String senderId =
        _stringValue(payloadMap['from_user_id']) ??
        _stringValue(payloadMap['sender_id']) ??
        _stringValue(payloadMap['user_id']) ??
        session.userId;
    final String receiverId =
        _stringValue(payloadMap['to_user_id']) ??
        _stringValue(payloadMap['receiver_id']) ??
        session.userId;
    final DateTime timestamp =
        _parseTimestamp(payloadMap['created_at'] ?? payloadMap['timestamp']) ??
        DateTime.now().toUtc();
    final String messageId =
        _stringValue(payloadMap['id']) ??
        _stringValue(payloadMap['message_id']) ??
        remoteEventId ??
        'remote-${timestamp.microsecondsSinceEpoch}';

    return Message(
      id: messageId,
      senderId: senderId,
      receiverId: receiverId,
      timestamp: timestamp,
      content: content,
      status: MessageStatus.delivered,
      conversationId: _conversationIdFor(
        currentUserId: session.userId,
        senderId: senderId,
        receiverId: receiverId,
      ),
      eventName: _stringValue(payloadMap['event']) ?? fallbackEventName,
      source:
          _stringValue(nestedPayload['source']) ??
          _stringValue(payloadMap['source']),
      isIncoming: receiverId == session.userId,
      remoteEventId: remoteEventId,
    );
  }

  Future<Message> _storeIncomingMessage(Message incoming) async {
    final List<Message> cached = await _cache.readAll();

    for (final Message existing in cached) {
      if (_shouldMerge(existing: existing, incoming: incoming)) {
        final Message merged = incoming.copyWith(
          id: existing.id,
          status: MessageStatus.delivered,
        );
        await _cache.write(merged.id, merged);
        return merged;
      }
    }

    await _cache.write(incoming.id, incoming);
    return incoming;
  }

  bool _shouldMerge({required Message existing, required Message incoming}) {
    if (existing.remoteEventId != null &&
        existing.remoteEventId == incoming.remoteEventId) {
      return true;
    }

    final Duration difference = existing.timestamp
        .difference(incoming.timestamp)
        .abs();

    return existing.senderId == incoming.senderId &&
        existing.receiverId == incoming.receiverId &&
        existing.content == incoming.content &&
        difference <= const Duration(seconds: 5);
  }

  Future<AuthSession> _requireSession() async {
    final AuthSession? session = await _authRepository.loadSession();
    if (session == null) {
      throw StateError('You must authenticate before messaging.');
    }
    return session;
  }

  String _conversationIdFor({
    required String currentUserId,
    required String senderId,
    required String receiverId,
  }) {
    return senderId == currentUserId ? receiverId : senderId;
  }

  DateTime? _parseTimestamp(Object? rawValue) {
    final String? value = _stringValue(rawValue);
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(value)?.toUtc();
  }

  Map<String, dynamic>? _castJsonMap(Object? raw) {
    if (raw is Map<String, dynamic>) {
      return raw;
    }

    if (raw is Map<Object?, Object?>) {
      return raw.map(
        (Object? key, Object? value) => MapEntry(key.toString(), value),
      );
    }

    return null;
  }

  List<dynamic>? _castJsonList(Object? raw) {
    if (raw is List<dynamic>) {
      return raw;
    }

    if (raw is Iterable) {
      return raw.toList(growable: false);
    }

    return null;
  }

  Map<String, String> _bearerHeaders(String token) {
    return <String, String>{'Authorization': 'Bearer $token'};
  }

  String? _stringValue(Object? rawValue) {
    if (rawValue == null) {
      return null;
    }

    final String value = rawValue.toString();
    return value.isEmpty ? null : value;
  }
}
