import 'package:thus_core/thus_core.dart';

import '../../data/auth_repository.dart';

class Logout extends UseCase<void, NoParams> {
  Logout(this._repository);

  final AuthRepository _repository;

  @override
  Future<void> call(NoParams params) {
    return _repository.logout();
  }
}
