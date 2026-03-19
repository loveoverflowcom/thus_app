import 'package:get_it/get_it.dart';
import 'package:thus_core/thus_core.dart';

import 'cache_repository.dart';
import 'hive_initializer.dart';

/// Registers storage-related dependencies into the provided [GetIt] instance.
Future<void> registerStorageModule(GetIt getIt) async {
  if (!getIt.isRegistered<HiveInitializer>()) {
    getIt.registerLazySingleton<HiveInitializer>(
      () => HiveInitializer(logger: getIt<AppLogger>()),
    );
  }

  // Example factories for common caches can be added here.
  if (!getIt.isRegistered<CacheRepositoryFactory>()) {
    getIt.registerLazySingleton<CacheRepositoryFactory>(
      () => CacheRepositoryFactory(getIt<HiveInitializer>()),
    );
  }
}

/// Factory helper to create typed cache repositories on demand.
class CacheRepositoryFactory {
  CacheRepositoryFactory(this._initializer);

  final HiveInitializer _initializer;

  CacheRepository<T> box<T>(
    String name, {
    required JsonDecoder<T> fromJson,
    required JsonEncoder<T> toJson,
    bool encrypted = false,
  }) {
    return CacheRepository<T>(
      _initializer,
      boxName: name,
      fromJson: fromJson,
      toJson: toJson,
      encrypted: encrypted,
    );
  }
}
