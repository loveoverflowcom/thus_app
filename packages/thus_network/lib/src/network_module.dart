import 'package:get_it/get_it.dart';
import 'package:thus_core/thus_core.dart';

import 'rest_client.dart';
import 'sse_client.dart';
import 'websocket_client.dart';

Future<void> registerNetworkModule(
  GetIt getIt, {
  String baseUrl = AppConstants.defaultApiBaseUrl,
}) async {
  if (!getIt.isRegistered<RestClient>()) {
    final dio = buildDio(baseUrl);
    getIt.registerLazySingleton<RestClient>(
      () => RestClient(dio: dio, logger: getIt<AppLogger>()),
    );
    getIt.registerLazySingleton<SseClient>(() => SseClient(dio));
  }

  if (!getIt.isRegistered<WebSocketClient>()) {
    getIt.registerFactoryParam<WebSocketClient, Uri, void>(
      (Uri uri, _) => connectWebSocket(uri),
    );
  }
}
