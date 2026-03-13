import 'package:thus_core/thus_core.dart';

import '../../data/identity_repository.dart';
import '../entities/user_identity.dart';

class SaveIdentity extends UseCase<UserIdentity, UserIdentity> {
  SaveIdentity(this._repository);

  final IdentityRepository _repository;

  @override
  Future<UserIdentity> call(UserIdentity params) => _repository.save(params);
}
