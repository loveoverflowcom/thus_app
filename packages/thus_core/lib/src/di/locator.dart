import 'package:get_it/get_it.dart';
import '../logger.dart';

final GetIt coreLocator = GetIt.instance;

/// Register core-level singletons available to all packages/apps.
Future<GetIt> configureCoreDependencies() async {
  if (!coreLocator.isRegistered<AppLogger>()) {
    coreLocator.registerLazySingleton<AppLogger>(() => const AppLogger());
  }
  return coreLocator;
}
