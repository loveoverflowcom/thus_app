import '../domain/entities/auth_credentials.dart';
import '../domain/entities/auth_session.dart';
import 'auth_local_data_source.dart';
import 'auth_remote_data_source.dart';
import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthLocalDataSource localDataSource,
    required AuthRemoteDataSource remoteDataSource,
  }) : _localDataSource = localDataSource,
       _remoteDataSource = remoteDataSource;

  final AuthLocalDataSource _localDataSource;
  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<AuthSession?> loadSession() {
    return _localDataSource.loadSession();
  }

  @override
  Future<AuthSession> login(AuthCredentials credentials) async {
    final AuthSession session = await _remoteDataSource.login(credentials);
    return _localDataSource.saveSession(session);
  }

  @override
  Future<AuthSession> register(AuthCredentials credentials) async {
    final AuthSession session = await _remoteDataSource.register(credentials);
    return _localDataSource.saveSession(session);
  }

  @override
  Future<AuthSession> refreshSession() async {
    final AuthSession? currentSession = await _localDataSource.loadSession();
    if (currentSession == null) {
      throw StateError('No persisted session to refresh.');
    }

    final AuthSession refreshed = await _remoteDataSource.refreshSession(
      currentSession,
    );
    return _localDataSource.saveSession(refreshed);
  }

  @override
  Future<void> logout() {
    return _localDataSource.clearSession();
  }
}
