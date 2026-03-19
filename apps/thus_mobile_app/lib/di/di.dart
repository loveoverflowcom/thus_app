import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';
import 'package:thus_network/thus_network.dart';
import 'package:thus_storage/thus_storage.dart';

final GetIt sl = GetIt.instance;

Future<void> configureAppDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureCoreDependencies();
  await registerStorageModule(sl);
  final storageDirectory = await getApplicationSupportDirectory();
  await sl<HiveInitializer>().init(storagePath: storageDirectory.path);
  await registerNetworkModule(sl);
  await registerAuthModule(sl);
  await registerMessagingModule(sl);
}
