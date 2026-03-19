import 'package:thus_core/thus_core.dart';

import '../../data/message_repository.dart';
import '../entities/message.dart';

class ReceiveMessage extends UseCase<Stream<Message>, NoParams> {
  ReceiveMessage(this._repository);

  final MessageRepository _repository;

  @override
  Future<Stream<Message>> call(NoParams params) async {
    return _repository.incoming();
  }
}
