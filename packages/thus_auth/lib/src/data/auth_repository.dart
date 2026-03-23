import 'package:fpdart/fpdart.dart';

import 'package:thus_auth/src/data/models/auth_session.dart';
import 'package:thus_auth/src/data/models/auth_failure.dart';

abstract class AuthRepository {
  TaskEither<AuthFailure, AuthSession?> loadSession();
  TaskEither<AuthFailure, AuthSession> login({
    required String username,
    required String password,
  });
  TaskEither<AuthFailure, AuthSession> register({
    required String username,
    required String password,
  });
  TaskEither<AuthFailure, AuthSession> refreshSession();
  TaskEither<AuthFailure, void> logout();
}
