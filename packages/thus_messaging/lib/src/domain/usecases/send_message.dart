import 'package:equatable/equatable.dart';
import 'package:thus_core/thus_core.dart';

import '../../data/message_repository.dart';
import '../entities/message.dart';

class SendMessage extends UseCase<Message, SendMessageParams> {
  SendMessage(this._repository);

  final MessageRepository _repository;

  @override
  Future<Message> call(SendMessageParams params) {
    return _repository.send(
      toUserId: params.toUserId,
      content: params.content,
      source: params.source,
    );
  }
}

class SendMessageParams extends Equatable {
  const SendMessageParams({
    required this.toUserId,
    required this.content,
    this.source = 'thus_mobile',
  });

  final String toUserId;
  final String content;
  final String source;

  @override
  List<Object?> get props => <Object?>[toUserId, content, source];
}
