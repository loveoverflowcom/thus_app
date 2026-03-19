import 'package:thus_core/thus_core.dart';

import '../../data/auth_repository.dart';
import '../entities/auth_session.dart';

class RefreshSession extends UseCase<AuthSession, NoParams> {
  RefreshSession(this._repository);

  final AuthRepository _repository;

  @override
  Future<AuthSession> call(NoParams params) {
    return _repository.refreshSession();
  }
}
