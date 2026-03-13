import '../domain/entities/user_identity.dart';

abstract class IdentityRepository {
  Future<UserIdentity?> load();
  Future<UserIdentity> save(UserIdentity identity);
}
