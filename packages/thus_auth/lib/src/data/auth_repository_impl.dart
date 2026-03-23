import 'package:fpdart/fpdart.dart';

import 'package:thus_auth/src/data/models/auth_credentials.dart';
import 'package:thus_auth/src/data/models/auth_session.dart';
import 'package:thus_auth/src/data/auth_local_data_source.dart';
import 'package:thus_auth/src/data/auth_remote_data_source.dart';
import 'package:thus_auth/src/data/auth_repository.dart';
import 'package:thus_auth/src/data/models/auth_failure.dart';

final class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthLocalDataSource localDataSource,
    required AuthRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  @override
  TaskEither<AuthFailure, AuthSession?> loadSession() {
    return TaskEither.tryCatch(
      _localDataSource.loadSession,
      (error, stackTrace) => AuthFailure.storage(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<AuthFailure, AuthSession> login({
    required String username,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        final session = await _remoteDataSource.login(
          AuthCredentials(username: username, password: password),
        );
        return _localDataSource.saveSession(session);
      },
      (error, stackTrace) => AuthFailure.network(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<AuthFailure, AuthSession> register({
    required String username,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        final session = await _remoteDataSource.register(
          AuthCredentials(username: username, password: password),
        );
        return _localDataSource.saveSession(session);
      },
      (error, stackTrace) => AuthFailure.network(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<AuthFailure, AuthSession> refreshSession() {
    return TaskEither.tryCatch(
      () async {
        final current = await _localDataSource.loadSession();
        if (current == null) {
          throw StateError('No persisted session to refresh.');
        }
        final refreshed = await _remoteDataSource.refreshSession(current);
        return _localDataSource.saveSession(refreshed);
      },
      (error, stackTrace) => AuthFailure.network(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  @override
  TaskEither<AuthFailure, void> logout() {
    return TaskEither.tryCatch(
      _localDataSource.clearSession,
      (error, stackTrace) => AuthFailure.storage(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }
}
