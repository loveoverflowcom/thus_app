import '../domain/entities/auth_credentials.dart';
import '../domain/entities/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession?> loadSession();
  Future<AuthSession> login(AuthCredentials credentials);
  Future<AuthSession> register(AuthCredentials credentials);
  Future<AuthSession> refreshSession();
  Future<void> logout();
}
