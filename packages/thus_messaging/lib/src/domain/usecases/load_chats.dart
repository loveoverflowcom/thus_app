import 'package:thus_core/thus_core.dart';

import '../../data/message_repository.dart';
import '../entities/chat.dart';

class LoadChats extends UseCase<List<Chat>, NoParams> {
  LoadChats(this._repository);

  final MessageRepository _repository;

  @override
  Future<List<Chat>> call(NoParams params) {
    return _repository.loadChats();
  }
}
