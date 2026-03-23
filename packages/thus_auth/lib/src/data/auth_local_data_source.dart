import 'package:thus_storage/thus_storage.dart';

import 'package:thus_auth/src/data/models/auth_session.dart';

class AuthLocalDataSource {
  AuthLocalDataSource(this._cacheRepository);

  static const String sessionKey = 'active_session';

  final CacheRepository<AuthSession> _cacheRepository;

  Future<AuthSession?> loadSession() {
    return _cacheRepository.read(sessionKey);
  }

  Future<AuthSession> saveSession(AuthSession session) async {
    await _cacheRepository.write(sessionKey, session);
    return session;
  }

  Future<void> clearSession() {
    return _cacheRepository.remove(sessionKey);
  }
}
