import 'package:get_it/get_it.dart';
import 'package:thus_storage/thus_storage.dart';

import '../data/identity_local_data_source.dart';
import '../data/identity_repository.dart';
import '../data/identity_repository_impl.dart';
import '../domain/entities/user_identity.dart';
import '../domain/usecases/generate_key_pair.dart';
import '../domain/usecases/load_identity.dart';
import '../domain/usecases/save_identity.dart';

Future<void> registerAuthModule(GetIt getIt) async {
  getIt.registerLazySingleton<IdentityLocalDataSource>(() {
    final cacheFactory = getIt<CacheRepositoryFactory>();
    return IdentityLocalDataSource(cacheFactory.box<UserIdentity>('identity', encrypted: true));
  });

  getIt.registerLazySingleton<IdentityRepository>(() => IdentityRepositoryImpl(getIt()));

  getIt.registerFactory(() => GenerateKeyPair(getIt()));
  getIt.registerFactory(() => LoadIdentity(getIt()));
  getIt.registerFactory(() => SaveIdentity(getIt()));
  getIt.registerFactory(() => AuthBloc(getIt(), getIt(), getIt()));
}
