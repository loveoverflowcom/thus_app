import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:thus_core/thus_core.dart';

import 'package:thus_network/src/http_log_interceptor.dart';

class RestClient {
  RestClient({
    required String baseUrl,
    required http.Client client,
    required AppLogger logger,
  }) : _baseUri = Uri.parse(baseUrl),
       _client = client,
       _logger = logger;

  static const Duration _requestTimeout = Duration(seconds: 10);
  static const Duration _responseTimeout = Duration(seconds: 30);

  final Uri _baseUri;
  final http.Client _client;
  final AppLogger _logger;

  Future<Map<String, dynamic>?> getJson(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final http.Response response = await get(
      path,
      query: query,
      headers: headers,
    );
    return _decodeJsonMap(response);
  }

  Future<List<dynamic>?> getJsonList(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final http.Response response = await get(
      path,
      query: query,
      headers: headers,
    );
    return _decodeJsonList(response);
  }

  Future<Map<String, dynamic>?> postJson(
    String path, {
    Object? data,
    Map<String, String>? headers,
  }) async {
    final http.Response response = await post(
      path,
      data: data,
      headers: headers,
    );
    return _decodeJsonMap(response);
  }

  Future<List<dynamic>?> postJsonList(
    String path, {
    Object? data,
    Map<String, String>? headers,
  }) async {
    final http.Response response = await post(
      path,
      data: data,
      headers: headers,
    );
    return _decodeJsonList(response);
  }

  Future<http.Response> get(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    return _send('GET', path, query: query, headers: headers);
  }

  Future<http.Response> post(
    String path, {
    Object? data,
    Map<String, String>? headers,
  }) async {
    return _send('POST', path, data: data, headers: headers);
  }

  Future<http.Response> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    return _send('PATCH', path, data: data, query: query, headers: headers);
  }

  Future<http.Response> delete(
    String path, {
    Map<String, dynamic>? query,
    Object? data,
    Map<String, String>? headers,
  }) async {
    return _send('DELETE', path, data: data, query: query, headers: headers);
  }

  Future<http.Response> _send(
    String method,
    String path, {
    Map<String, dynamic>? query,
    Object? data,
    Map<String, String>? headers,
  }) async {
    final Uri uri = _buildUri(path, query: query);
    final http.Request request = http.Request(method, uri);
    request.headers.addAll(
      _headersFor(headers: headers, hasBody: data != null),
    );

    if (data != null) {
      request.body = data is String ? data : jsonEncode(data);
    }

    try {
      final http.StreamedResponse streamedResponse = await _client
          .send(request)
          .timeout(_requestTimeout);
      final http.Response response = await http.Response.fromStream(
        streamedResponse,
      ).timeout(_responseTimeout);

      _throwIfError(response);
      return response;
    } on TimeoutException catch (error, stackTrace) {
      _logger.log(
        'HTTP $method $uri timed out.',
        level: LogLevel.error,
        error: error,
        stackTrace: stackTrace,
      );
      throw Exception('HTTP $method $uri timed out.');
    } on http.ClientException catch (error, stackTrace) {
      _logger.log(
        'HTTP $method $uri failed.',
        level: LogLevel.error,
        error: error,
        stackTrace: stackTrace,
      );
      throw Exception('HTTP $method $uri failed: ${error.message}');
    }
  }

  Uri _buildUri(String path, {Map<String, dynamic>? query}) {
    final Uri resolved = _baseUri.resolve(path);
    if (query == null || query.isEmpty) {
      return resolved;
    }

    final Map<String, List<String>> mergedQueryParameters =
        Map<String, List<String>>.from(resolved.queryParametersAll);

    for (final MapEntry<String, dynamic> entry in query.entries) {
      final dynamic value = entry.value;
      if (value == null) {
        continue;
      }

      if (value is Iterable) {
        mergedQueryParameters[entry.key] = value
            .map((dynamic item) => item.toString())
            .toList(growable: false);
        continue;
      }

      mergedQueryParameters[entry.key] = <String>[value.toString()];
    }

    final String queryString = _encodeQueryString(mergedQueryParameters);
    return resolved.replace(query: queryString.isEmpty ? null : queryString);
  }

  Map<String, String> _headersFor({
    required bool hasBody,
    Map<String, String>? headers,
  }) {
    return <String, String>{
      'Accept': 'application/json',
      if (hasBody) 'Content-Type': 'application/json',
      ...?headers,
    };
  }

  String _encodeQueryString(Map<String, List<String>> queryParameters) {
    return queryParameters.entries
        .expand(
          (MapEntry<String, List<String>> entry) => entry.value.map(
            (String value) =>
                '${Uri.encodeQueryComponent(entry.key)}='
                '${Uri.encodeQueryComponent(value)}',
          ),
        )
        .join('&');
  }

  Map<String, dynamic>? _decodeJsonMap(http.Response response) {
    final Object? decoded = _decodeJsonBody(response);
    if (decoded == null) {
      return null;
    }
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }
    if (decoded is Map<Object?, Object?>) {
      return decoded.map(
        (Object? key, Object? value) => MapEntry(key.toString(), value),
      );
    }

    throw const FormatException('Expected JSON object response.');
  }

  List<dynamic>? _decodeJsonList(http.Response response) {
    final Object? decoded = _decodeJsonBody(response);
    if (decoded == null) {
      return null;
    }
    if (decoded is List<dynamic>) {
      return decoded;
    }

    throw const FormatException('Expected JSON array response.');
  }

  Object? _decodeJsonBody(http.Response response) {
    if (response.bodyBytes.isEmpty) {
      return null;
    }

    final String body = utf8.decode(response.bodyBytes).trim();
    if (body.isEmpty) {
      return null;
    }

    return jsonDecode(body);
  }

  void _throwIfError(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    throw Exception(
      'HTTP ${response.statusCode} ${response.request?.method ?? 'REQUEST'} '
      '${response.request?.url ?? '<unknown>'}: ${response.body}',
    );
  }
}

http.Client buildHttpClient({required AppLogger logger}) {
  return InterceptedClient.build(
    interceptors: <InterceptorContract>[HttpLogInterceptor(logger)],
  );
}
