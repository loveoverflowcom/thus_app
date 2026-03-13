import 'dart:async';
import 'dart:convert';

import 'package:thus_core/thus_core.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

import '../domain/entities/message.dart';
import '../domain/entities/message_status.dart';
import 'message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  MessageRepositoryImpl({
    required RestClient restClient,
    required WebSocketClient Function(Uri) socketFactory,
    required CacheRepository<Message> cache,
  })  : _restClient = restClient,
        _socketFactory = socketFactory,
        _cache = cache;

  final RestClient _restClient;
  final WebSocketClient Function(Uri) _socketFactory;
  final CacheRepository<Message> _cache;

  WebSocketClient? _socket;

  @override
  Future<Message> send(Message message) async {
    await _restClient.post('/messages', data: message.toJson());
    final persisted = message.copyWith(status: MessageStatus.sent);
    await _cache.write(message.id, persisted);
    return persisted;
  }

  @override
  Stream<Message> incoming() {
    _socket ??= _socketFactory(Uri.parse('${AppConstants.defaultApiBaseUrl}${AppConstants.websocketPath}'));
    return _socket!.stream.map<Message>((event) {
      if (event is Message) return event;
      if (event is String) {
        return Message.fromJson(jsonDecode(event) as Map<String, dynamic>);
      }
      return Message.fromJson(Map<String, dynamic>.from(event as Map));
    });
  }

  @override
  Future<List<Message>> loadHistory(String conversationId) async {
    final cached = await _cache.readAll();
    final filtered = cached.where((m) => m.conversationId == conversationId).toList();
    if (filtered.isNotEmpty) return filtered;

    final response = await _restClient.get<List<dynamic>>('/conversations/$conversationId/messages');
    final data = response.data ?? [];
    final messages = data
        .map((e) => Message.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
    for (final message in messages) {
      await _cache.write(message.id, message);
    }
    return messages;
  }

  @override
  Stream<Message> subscribe(String conversationId) => incoming()
      .where((message) => message.conversationId == conversationId)
      .asBroadcastStream();
}
