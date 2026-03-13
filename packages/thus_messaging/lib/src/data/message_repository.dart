import '../domain/entities/message.dart';

abstract class MessageRepository {
  Future<Message> send(Message message);
  Stream<Message> incoming();
  Future<List<Message>> loadHistory(String conversationId);
  Stream<Message> subscribe(String conversationId);
}
