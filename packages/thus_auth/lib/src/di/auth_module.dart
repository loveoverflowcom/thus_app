import 'package:get_it/get_it.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

import '../data/auth_local_data_source.dart';
import '../data/auth_remote_data_source.dart';
import '../data/auth_repository.dart';
import '../data/auth_repository_impl.dart';
import '../domain/entities/auth_session.dart';
import '../domain/usecases/load_session.dart';
import '../domain/usecases/login.dart';
import '../domain/usecases/logout.dart';
import '../domain/usecases/refresh_session.dart';
import '../domain/usecases/register_account.dart';
import '../presentation/auth_bloc.dart';

Future<void> registerAuthModule(GetIt getIt) async {
  if (!getIt.isRegistered<AuthLocalDataSource>()) {
    getIt.registerLazySingleton<AuthLocalDataSource>(() {
      final CacheRepositoryFactory cacheFactory =
          getIt<CacheRepositoryFactory>();
      return AuthLocalDataSource(
        cacheFactory.box<AuthSession>(
          'auth_session',
          fromJson: AuthSession.fromJson,
          toJson: (AuthSession value) => value.toJson(),
          encrypted: true,
        ),
      );
    });
  }

  if (!getIt.isRegistered<AuthRemoteDataSource>()) {
    getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        restClient: getIt<RestClient>(),
        logger: getIt<AppLogger>(),
      ),
    );
  }

  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        localDataSource: getIt<AuthLocalDataSource>(),
        remoteDataSource: getIt<AuthRemoteDataSource>(),
      ),
    );
  }

  getIt.registerFactory(() => LoadSession(getIt<AuthRepository>()));
  getIt.registerFactory(() => Login(getIt<AuthRepository>()));
  getIt.registerFactory(() => RegisterAccount(getIt<AuthRepository>()));
  getIt.registerFactory(() => RefreshSession(getIt<AuthRepository>()));
  getIt.registerFactory(() => Logout(getIt<AuthRepository>()));
  getIt.registerFactory(
    () => AuthBloc(
      loadSession: getIt<LoadSession>(),
      login: getIt<Login>(),
      registerAccount: getIt<RegisterAccount>(),
      refreshSession: getIt<RefreshSession>(),
      logout: getIt<Logout>(),
    ),
  );
}
