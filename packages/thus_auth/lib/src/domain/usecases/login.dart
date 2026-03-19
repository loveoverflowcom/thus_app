import 'package:thus_core/thus_core.dart';

import '../../data/auth_repository.dart';
import '../entities/auth_credentials.dart';
import '../entities/auth_session.dart';

class Login extends UseCase<AuthSession, AuthCredentials> {
  Login(this._repository);

  final AuthRepository _repository;

  @override
  Future<AuthSession> call(AuthCredentials params) {
    return _repository.login(params);
  }
}
