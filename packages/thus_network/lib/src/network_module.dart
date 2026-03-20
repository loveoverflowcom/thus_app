import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:thus_core/thus_core.dart';

import 'rest_client.dart';
import 'sse_client.dart';
import 'websocket_client.dart';

Future<void> registerNetworkModule(
  GetIt getIt, {
  String baseUrl = AppConstants.defaultApiBaseUrl,
}) async {
  if (!getIt.isRegistered<http.Client>()) {
    getIt.registerLazySingleton<http.Client>(
      () => buildHttpClient(logger: getIt<AppLogger>()),
    );
  }

  if (!getIt.isRegistered<RestClient>()) {
    getIt.registerLazySingleton<RestClient>(
      () => RestClient(
        baseUrl: baseUrl,
        client: getIt<http.Client>(),
        logger: getIt<AppLogger>(),
      ),
    );
    getIt.registerLazySingleton<SseClient>(
      () => SseClient(
        baseUrl: baseUrl,
        client: getIt<http.Client>(),
        logger: getIt<AppLogger>(),
      ),
    );
  }

  if (!getIt.isRegistered<WebSocketClient>()) {
    getIt.registerFactoryParam<WebSocketClient, Uri, void>(
      (Uri uri, _) => connectWebSocket(uri),
    );
  }
}
