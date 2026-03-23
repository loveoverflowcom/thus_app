import 'dart:async';
import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

import 'package:thus_messaging/src/data/models/chat.dart';
import 'package:thus_messaging/src/data/models/message.dart';
import 'package:thus_messaging/src/data/models/message_status.dart';
import 'package:thus_messaging/src/data/message_repository/message_repository.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_domain_event.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_failure.dart';

final class MessageRepositoryImpl extends MessageRepository {
  MessageRepositoryImpl({
    required RestClient restClient,
    required SseClient sseClient,
    required CacheRepository<Message> cache,
    required AuthRepository authRepository,
    required AppLogger logger,
  })  : _restClient = restClient,
        _sseClient = sseClient,
        _cache = cache,
        _authRepository = authRepository,
        _logger = logger;

  final RestClient _restClient;
  final SseClient _sseClient;
  final CacheRepository<Message> _cache;
  final AuthRepository _authRepository;
  final AppLogger _logger;

  final _eventController = StreamController<MessageDomainEvent>.broadcast();
  StreamSubscription<void>? _sseSubscription;

  @override
  Stream<MessageDomainEvent> get events => _eventController.stream;

  @override
  TaskEither<MessageFailure, Message> send({
    required String receiverId,
    required String content,
    String source = 'thus_mobile',
  }) {
    if (!isUuid(receiverId.trim())) {
      return TaskEither.left(
        MessageFailure.other(
          code: 400,
          message: 'Target user id must be a UUID, not a username.',
          stackTrace: StackTrace.current,
        ),
      );
    }

    return TaskEither.tryCatch(
      () async {
        final session = await _requireSession();
        final normalizedId = receiverId.trim();
        final draft = Message(
          id: 'local-${DateTime.now().microsecondsSinceEpoch}',
          senderId: session.userId,
          receiverId: normalizedId,
          timestamp: DateTime.now().toUtc(),
          content: content,
          status: MessageStatus.sending,
          conversationId: normalizedId,
          source: source,
          isIncoming: false,
        );

        await _cache.write(draft.id, draft);

        final response = await _restClient.postJson(
          AppConstants.sendMessagePath,
          data: <String, dynamic>{
            'to_user_id': normalizedId,
            'event': draft.eventName,
            'payload': <String, dynamic>{'body': content, 'source': source},
          },
          headers: _bearerHeaders(session.accessToken),
        );

        final deliveredConnections =
            (response?['delivered_connections'] as num?)?.toInt() ?? 0;
        final queuedMessages =
            (response?['queued_messages'] as num?)?.toInt() ?? 0;

        final persisted = draft.copyWith(
          status: deliveredConnections > 0 || queuedMessages > 0
              ? MessageStatus.sent
              : MessageStatus.sent,
        );

        await _cache.write(persisted.id, persisted);
        return persisted;
      },
      (error, stackTrace) => MessageFailure.network(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<MessageFailure, List<Message>> loadHistory(
    String conversationId,
  ) {
    return TaskEither.tryCatch(
      () async {
        final cached = await _cache.readAll();
        return cached
            .where((m) => m.conversationId == conversationId)
            .toList(growable: false)
          ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
      },
      (error, stackTrace) => MessageFailure.storage(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<MessageFailure, List<Chat>> loadChats() {
    return TaskEither.tryCatch(
      () async {
        final cached = await _cache.readAll();
        final grouped = <String, List<Message>>{};
        for (final m in cached) {
          grouped.putIfAbsent(m.conversationId, () => []).add(m);
        }

        return grouped.entries.map((entry) {
          final messages = entry.value
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
          final last = messages.first;
          return Chat(
            id: entry.key,
            title: entry.key,
            participantIds: [last.senderId, last.receiverId],
            lastMessage: last,
            updatedAt: last.timestamp,
          );
        }).toList(growable: false)
          ..sort((a, b) {
            final aDate = a.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bDate = b.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bDate.compareTo(aDate);
          });
      },
      (error, stackTrace) => MessageFailure.storage(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<MessageFailure, void> startListening() {
    return TaskEither.tryCatch(
      () async {
        final session = await _requireSession();
        _sseSubscription = _sseClient
            .listen(
              AppConstants.eventsPath,
              headers: _bearerHeaders(session.notificationToken),
            )
            .asyncMap((event) => _handleSseEvent(event, session))
            .listen((_) {});
      },
      (error, stackTrace) => MessageFailure.network(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  void dispose() {
    _sseSubscription?.cancel();
    _eventController.close();
  }

  Future<void> _handleSseEvent(SseEvent event, AuthSession session) async {
    final messages = _mapSseEventToMessages(event: event, session: session);
    for (final message in messages) {
      final stored = await _storeIncomingMessage(message);
      _eventController.add(
        MessageDomainEvent.received(
          conversationId: stored.conversationId,
          messageId: stored.id,
        ),
      );
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
      return [];
    }

    final decodedMap = _castJsonMap(decoded);
    if (event.event == 'system.ready' && decodedMap != null) {
      final replayed = _castJsonList(decodedMap['replayed_messages']) ?? [];
      return replayed
          .map((raw) => _mapPayloadToMessage(
                raw: raw,
                fallbackEventName: 'chat.message',
                session: session,
              ))
          .whereType<Message>()
          .toList(growable: false);
    }

    final message = _mapPayloadToMessage(
      raw: decoded,
      fallbackEventName: event.event,
      session: session,
      remoteEventId: event.id,
    );
    return message != null ? [message] : [];
  }

  Message? _mapPayloadToMessage({
    required dynamic raw,
    required String fallbackEventName,
    required AuthSession session,
    String? remoteEventId,
  }) {
    final payloadMap = _castJsonMap(raw);
    if (payloadMap == null) return null;

    final nestedPayload =
        _castJsonMap(payloadMap['payload']) ?? <String, dynamic>{};
    final content = _stringValue(nestedPayload['body']) ??
        _stringValue(payloadMap['body']) ??
        _stringValue(payloadMap['message']);

    if (content == null || content.trim().isEmpty) return null;

    final senderId = _stringValue(payloadMap['from_user_id']) ??
        _stringValue(payloadMap['sender_id']) ??
        session.userId;
    final receiverId = _stringValue(payloadMap['to_user_id']) ??
        _stringValue(payloadMap['receiver_id']) ??
        session.userId;
    final timestamp =
        _parseTimestamp(payloadMap['created_at'] ?? payloadMap['timestamp']) ??
            DateTime.now().toUtc();
    final messageId = _stringValue(payloadMap['id']) ??
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
      conversationId: senderId == session.userId ? receiverId : senderId,
      eventName: _stringValue(payloadMap['event']) ?? fallbackEventName,
      source: _stringValue(nestedPayload['source']) ??
          _stringValue(payloadMap['source']),
      isIncoming: receiverId == session.userId,
      remoteEventId: remoteEventId,
    );
  }

  Future<Message> _storeIncomingMessage(Message incoming) async {
    final cached = await _cache.readAll();
    for (final existing in cached) {
      if (_shouldMerge(existing: existing, incoming: incoming)) {
        final merged =
            incoming.copyWith(id: existing.id, status: MessageStatus.delivered);
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
    final diff = existing.timestamp.difference(incoming.timestamp).abs();
    return existing.senderId == incoming.senderId &&
        existing.receiverId == incoming.receiverId &&
        existing.content == incoming.content &&
        diff <= const Duration(seconds: 5);
  }

  Future<AuthSession> _requireSession() async {
    final result = await _authRepository.loadSession().run();
    return result.match(
      (failure) => throw StateError(switch (failure) {
        AuthNetworkFailure(:final message) => message,
        AuthUnauthorizedFailure(:final message) => message,
        AuthStorageFailure(:final message) => message,
        AuthOtherFailure(:final message) => message,
      }),
      (session) {
        if (session == null) throw StateError('Not authenticated.');
        return session;
      },
    );
  }

  Map<String, String> _bearerHeaders(String token) =>
      {'Authorization': 'Bearer $token'};

  Map<String, dynamic>? _castJsonMap(Object? raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map<Object?, Object?>) {
      return raw.map((k, v) => MapEntry(k.toString(), v));
    }
    return null;
  }

  List<dynamic>? _castJsonList(Object? raw) {
    if (raw is List<dynamic>) return raw;
    if (raw is Iterable) return raw.toList(growable: false);
    return null;
  }

  String? _stringValue(Object? raw) {
    if (raw == null) return null;
    final s = raw.toString();
    return s.isEmpty ? null : s;
  }

  DateTime? _parseTimestamp(Object? raw) {
    final s = _stringValue(raw);
    if (s == null) return null;
    return DateTime.tryParse(s)?.toUtc();
  }
  
}
