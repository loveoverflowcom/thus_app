import 'package:fpdart/fpdart.dart';
import 'package:thus_messaging/src/data/models/chat.dart';
import 'package:thus_messaging/src/data/models/message.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_domain_event.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_failure.dart';

abstract class MessageRepository {
  /// Broadcast stream of all domain events (received messages, etc.)
  Stream<MessageDomainEvent> get events;

  /// Convenience stream that emits only incoming [MessageDomainEvent.received] events.
  Stream<MessageDomainEvent> get incomingMessages =>
      events.where((e) => e is MessageReceived);

  TaskEither<MessageFailure, Message> send({
    required String receiverId,
    required String content,
    String source,
  });

  TaskEither<MessageFailure, List<Message>> loadHistory(String conversationId);

  TaskEither<MessageFailure, List<Chat>> loadChats();

  /// Starts listening for incoming SSE messages. Call once at app startup.
  TaskEither<MessageFailure, void> startListening();

  void dispose();
}
