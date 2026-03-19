import 'package:thus_core/thus_core.dart';

import '../../data/message_repository.dart';
import '../entities/message.dart';

class LoadChatHistory extends UseCase<List<Message>, String> {
  LoadChatHistory(this._repository);

  final MessageRepository _repository;

  @override
  Future<List<Message>> call(String conversationId) {
    return _repository.loadHistory(conversationId);
  }
}
