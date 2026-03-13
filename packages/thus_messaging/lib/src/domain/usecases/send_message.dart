import 'package:thus_core/thus_core.dart';

import '../entities/message.dart';
import '../entities/message_status.dart';
import '../../data/message_repository.dart';

class SendMessage extends UseCase<Message, Message> {
  SendMessage(this._repository);

  final MessageRepository _repository;

  @override
  Future<Message> call(Message params) async {
    final sending = params.copyWith(status: MessageStatus.sending);
    return _repository.send(sending);
  }
}
