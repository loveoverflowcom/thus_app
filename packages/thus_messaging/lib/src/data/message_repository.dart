import '../domain/entities/chat.dart';
import '../domain/entities/message.dart';

abstract class MessageRepository {
  Future<Message> send({
    required String toUserId,
    required String content,
    String source,
  });

  Stream<Message> incoming();

  Future<List<Message>> loadHistory(String conversationId);

  Stream<Message> subscribe(String conversationId);

  Future<List<Chat>> loadChats();
}
