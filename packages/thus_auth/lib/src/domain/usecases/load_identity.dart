import 'package:thus_core/thus_core.dart';

import '../../data/identity_repository.dart';
import '../entities/user_identity.dart';

class LoadIdentity extends UseCase<UserIdentity?, NoParams> {
  LoadIdentity(this._repository);

  final IdentityRepository _repository;

  @override
  Future<UserIdentity?> call(NoParams params) => _repository.load();
}
