import 'package:dio/dio.dart';
import 'package:thus_core/thus_core.dart';

class RestClient {
  RestClient({required Dio dio, required AppLogger logger})
      : _dio = dio,
        _logger = logger;

  final Dio _dio;
  final AppLogger _logger;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) async {
    _logger.log('GET $path');
    return _dio.get<T>(path, queryParameters: query);
  }

  Future<Response<T>> post<T>(String path, {Object? data}) async {
    _logger.log('POST $path');
    return _dio.post<T>(path, data: data);
  }

  Dio get raw => _dio;
}

Dio buildDio(String baseUrl) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 10)));
  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  return dio;
}
