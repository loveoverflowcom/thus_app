import 'identity_local_data_source.dart';
import 'identity_repository.dart';
import '../domain/entities/user_identity.dart';

class IdentityRepositoryImpl implements IdentityRepository {
  IdentityRepositoryImpl(this._localDataSource);

  final IdentityLocalDataSource _localDataSource;

  @override
  Future<UserIdentity?> load() => _localDataSource.load();

  @override
  Future<UserIdentity> save(UserIdentity identity) => _localDataSource.save(identity);
}
