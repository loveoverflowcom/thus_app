import 'package:dio/dio.dart';
import 'package:thus_core/thus_core.dart';

class RestClient {
  RestClient({required Dio dio, required AppLogger logger})
    : _dio = dio,
      _logger = logger;

  final Dio _dio;
  final AppLogger _logger;

  Future<Map<String, dynamic>?> getJson(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final Response<Map<String, dynamic>> response =
        await get<Map<String, dynamic>>(path, query: query, headers: headers);
    return response.data;
  }

  Future<List<dynamic>?> getJsonList(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final Response<List<dynamic>> response = await get<List<dynamic>>(
      path,
      query: query,
      headers: headers,
    );
    return response.data;
  }

  Future<Map<String, dynamic>?> postJson(
    String path, {
    Object? data,
    Map<String, String>? headers,
  }) async {
    final Response<Map<String, dynamic>> response =
        await post<Map<String, dynamic>>(path, data: data, headers: headers);
    return response.data;
  }

  Future<List<dynamic>?> postJsonList(
    String path, {
    Object? data,
    Map<String, String>? headers,
  }) async {
    final Response<List<dynamic>> response = await post<List<dynamic>>(
      path,
      data: data,
      headers: headers,
    );
    return response.data;
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    _logger.log('GET $path');
    return _dio.get<T>(
      path,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, String>? headers,
  }) async {
    _logger.log('POST $path');
    return _dio.post<T>(
      path,
      data: data,
      options: Options(headers: headers),
    );
  }

  Future<Response<T>> patch<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    _logger.log('PATCH $path');
    return _dio.patch<T>(
      path,
      data: data,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  Future<Response<T>> delete<T>(
    String path, {
    Map<String, dynamic>? query,
    Object? data,
    Map<String, String>? headers,
  }) async {
    _logger.log('DELETE $path');
    return _dio.delete<T>(
      path,
      queryParameters: query,
      data: data,
      options: Options(headers: headers),
    );
  }

  Dio get raw => _dio;
}

Dio buildDio(String baseUrl) {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
      headers: <String, String>{'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

  return dio;
}
