import 'package:thus_storage/thus_storage.dart';

import '../domain/entities/user_identity.dart';

class IdentityLocalDataSource {
  IdentityLocalDataSource(this._cacheRepository);

  final CacheRepository<UserIdentity> _cacheRepository;
  static const _key = 'identity';

  Future<UserIdentity?> load() => _cacheRepository.read(_key);

  Future<UserIdentity> save(UserIdentity identity) async {
    await _cacheRepository.write(_key, identity);
    return identity;
  }
}
