import 'package:thus_core/thus_core.dart';

import '../../data/message_repository.dart';
import '../entities/message.dart';

class SubscribeChatStream extends UseCase<Stream<Message>, String> {
  SubscribeChatStream(this._repository);

  final MessageRepository _repository;

  @override
  Future<Stream<Message>> call(String conversationId) async => _repository.subscribe(conversationId);
}
