import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';
import 'package:thus_messaging/src/data/message_repository_impl.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

void main() {
  group('Chat', () {
    test('stores last message metadata', () {
      final Message message = Message(
        id: 'message-1',
        senderId: 'user-1',
        receiverId: 'user-2',
        content: 'hello',
        timestamp: DateTime.utc(2026, 3, 19),
        status: MessageStatus.sent,
        conversationId: 'conversation-1',
        source: 'test',
        isIncoming: false,
      );
      final Chat chat = Chat(
        id: 'conversation-1',
        title: 'Direct chat',
        participantIds: const <String>['user-1', 'user-2'],
        lastMessage: message,
        updatedAt: message.timestamp,
      );

      expect(chat.lastMessage, message);
      expect(chat.updatedAt, message.timestamp);
    });
  });

  group('MessageRepositoryImpl.incoming', () {
    test(
      'ignores malformed system.ready replayed_messages and keeps streaming',
      () async {
        final _TestLogger logger = _TestLogger();
        final AuthSession session = AuthSession(
          userId: 'current-user',
          username: 'alice',
          accessToken: 'access-token',
          refreshToken: 'refresh-token',
          notificationToken: 'notification-token',
          authenticatedAt: DateTime.utc(2026, 3, 20),
        );
        final MessageRepositoryImpl repository = MessageRepositoryImpl(
          restClient: RestClient(
            baseUrl: 'http://localhost:3000',
            client: _NoopHttpClient(),
            logger: logger,
          ),
          sseClient: _FakeSseClient(<SseEvent>[
            const SseEvent(
              event: 'system.ready',
              data: '{"replayed_messages":1}',
            ),
            const SseEvent(
              event: 'chat.message',
              id: 'evt-1',
              data: '''
{
  "id": "msg-1",
  "from_user_id": "remote-user",
  "to_user_id": "current-user",
  "created_at": "2026-03-20T01:02:03Z",
  "payload": {
    "body": "hello from SSE",
    "source": "test"
  }
}
''',
            ),
          ]),
          cache: _InMemoryMessageCache(),
          authRepository: _FakeAuthRepository(session),
          logger: logger,
        );

        final Message message = await repository.incoming().first;

        expect(message.id, 'msg-1');
        expect(message.content, 'hello from SSE');
        expect(message.senderId, 'remote-user');
        expect(message.receiverId, 'current-user');
        expect(message.conversationId, 'remote-user');
        expect(message.remoteEventId, 'evt-1');
        expect(message.isIncoming, isTrue);
        expect(
          logger.messages,
          contains(
            'Ignoring system.ready replayed_messages with unexpected type int.',
          ),
        );
      },
    );

    test('creates a fresh SSE subscription after the previous one ends', () async {
      final _TestLogger logger = _TestLogger();
      final AuthSession session = AuthSession(
        userId: 'current-user',
        username: 'alice',
        accessToken: 'access-token',
        refreshToken: 'refresh-token',
        notificationToken: 'notification-token',
        authenticatedAt: DateTime.utc(2026, 3, 20),
      );
      final _SequenceSseClient sseClient = _SequenceSseClient(<List<SseEvent>>[
        const <SseEvent>[
          SseEvent(
            event: 'chat.message',
            id: 'evt-1',
            data:
                '{"id":"msg-1","from_user_id":"remote-user","to_user_id":"current-user","created_at":"2026-03-20T01:02:03Z","payload":{"body":"first","source":"test"}}',
          ),
        ],
        const <SseEvent>[
          SseEvent(
            event: 'chat.message',
            id: 'evt-2',
            data:
                '{"id":"msg-2","from_user_id":"remote-user","to_user_id":"current-user","created_at":"2026-03-20T01:02:04Z","payload":{"body":"second","source":"test"}}',
          ),
        ],
      ]);
      final MessageRepositoryImpl repository = MessageRepositoryImpl(
        restClient: RestClient(
          baseUrl: 'http://localhost:3000',
          client: _NoopHttpClient(),
          logger: logger,
        ),
        sseClient: sseClient,
        cache: _InMemoryMessageCache(),
        authRepository: _FakeAuthRepository(session),
        logger: logger,
      );

      final List<Message> firstRun = await repository.incoming().toList();
      final List<Message> secondRun = await repository.incoming().toList();

      expect(firstRun.map((Message message) => message.content), <String>[
        'first',
      ]);
      expect(secondRun.map((Message message) => message.content), <String>[
        'second',
      ]);
      expect(sseClient.listenCallCount, 2);
    });
  });
}

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository(this._session);

  final AuthSession _session;

  @override
  Future<AuthSession> login(AuthCredentials credentials) {
    throw UnimplementedError();
  }

  @override
  Future<AuthSession?> loadSession() async => _session;

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<AuthSession> refreshSession() {
    throw UnimplementedError();
  }

  @override
  Future<AuthSession> register(AuthCredentials credentials) {
    throw UnimplementedError();
  }
}

class _FakeSseClient extends SseClient {
  _FakeSseClient(this._events)
    : super(
        baseUrl: 'http://localhost:3000',
        client: _NoopHttpClient(),
        logger: const AppLogger(),
      );

  final List<SseEvent> _events;

  @override
  Stream<SseEvent> listen(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async* {
    yield* Stream<SseEvent>.fromIterable(_events);
  }
}

class _SequenceSseClient extends SseClient {
  _SequenceSseClient(this._eventBatches)
    : super(
        baseUrl: 'http://localhost:3000',
        client: _NoopHttpClient(),
        logger: const AppLogger(),
      );

  final List<List<SseEvent>> _eventBatches;
  int listenCallCount = 0;

  @override
  Stream<SseEvent> listen(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async* {
    final int index = listenCallCount++;
    if (index >= _eventBatches.length) {
      return;
    }

    yield* Stream<SseEvent>.fromIterable(_eventBatches[index]);
  }
}

class _InMemoryMessageCache extends CacheRepository<Message> {
  _InMemoryMessageCache()
    : super(
        HiveInitializer(logger: const AppLogger()),
        boxName: 'test-messages',
        fromJson: Message.fromJson,
        toJson: (Message value) => value.toJson(),
      );

  final Map<String, Message> _store = <String, Message>{};

  @override
  Future<void> clear() async {
    _store.clear();
  }

  @override
  Future<Message?> read(String key) async => _store[key];

  @override
  Future<List<Message>> readAll() async =>
      _store.values.toList(growable: false);

  @override
  Future<void> remove(String key) async {
    _store.remove(key);
  }

  @override
  Future<void> write(String key, Message value) async {
    _store[key] = value;
  }

  @override
  Stream<List<Message>> watchAll() async* {
    yield _store.values.toList(growable: false);
  }
}

class _TestLogger extends AppLogger {
  final List<String> messages = <String>[];

  @override
  void log(
    String message, {
    LogLevel level = LogLevel.info,
    Object? error,
    StackTrace? stackTrace,
  }) {
    messages.add(message);
  }
}

class _NoopHttpClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }
}
