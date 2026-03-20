// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:thus_core/thus_core.dart';

class HttpLogInterceptor extends InterceptorContract {
  HttpLogInterceptor(this._logger);

  static int _nextRequestId = 0;

  final AppLogger _logger;
  final Expando<_RequestTrace> _traces = Expando<_RequestTrace>();

  @override
  Future<http.BaseRequest> interceptRequest({
    required http.BaseRequest request,
  }) async {
    final int requestId = ++_nextRequestId;
    _traces[request] = _RequestTrace(
      requestId: requestId,
      startedAt: DateTime.now(),
    );

    final String requestLog = _formatRequestLog(
      requestId: requestId,
      request: request,
    );
    _logger.log(requestLog, level: LogLevel.info);
    print(requestLog);

    return request;
  }

  @override
  Future<http.BaseResponse> interceptResponse({
    required http.BaseResponse response,
  }) async {
    final http.BaseRequest? request = _requestFor(response);
    final String responseLog = _formatResponseLog(
      requestId: _requestIdFor(request),
      request: request,
      statusCode: response.statusCode,
      elapsed: _elapsedFor(request),
      body: _formatResponseBody(response),
      label: 'RESPONSE',
    );
    _logger.log(responseLog, level: LogLevel.info);
    print(responseLog);

    return response;
  }

  String _formatRequestLog({
    required int requestId,
    required http.BaseRequest request,
  }) {
    final StringBuffer buffer = StringBuffer()
      ..writeln(_divider('HTTP #$requestId REQUEST'))
      ..writeln('${request.method.toUpperCase()} ${request.url}');

    final String? authorization = _authorizationPreview(request.headers);
    if (authorization != null) {
      buffer.writeln('auth: $authorization');
    }

    buffer
      ..writeln('body:')
      ..writeln(_formatRequestBody(request))
      ..writeln(_dividerEnd());

    return buffer.toString().trimRight();
  }

  String _formatResponseLog({
    required int requestId,
    required http.BaseRequest? request,
    required int? statusCode,
    required Duration elapsed,
    required String body,
    required String label,
    String? errorMessage,
  }) {
    final String method = request?.method.toUpperCase() ?? 'REQUEST';
    final Uri url = request?.url ?? Uri();
    final StringBuffer buffer = StringBuffer()
      ..writeln(_divider('HTTP #$requestId $label'))
      ..writeln('$method $url')
      ..writeln(
        'status: ${statusCode ?? 'NO_RESPONSE'} (${elapsed.inMilliseconds} ms)',
      );

    if (errorMessage != null &&
        errorMessage.trim().isNotEmpty &&
        errorMessage.trim() != body.trim()) {
      buffer.writeln('error: $errorMessage');
    }

    buffer
      ..writeln('body:')
      ..writeln(body)
      ..writeln(_dividerEnd());

    return buffer.toString().trimRight();
  }

  http.BaseRequest? _requestFor(http.BaseResponse response) {
    if (response is http.Response) {
      return response.request;
    }
    if (response is http.StreamedResponse) {
      return response.request;
    }
    return null;
  }

  int _requestIdFor(http.BaseRequest? request) {
    final _RequestTrace? trace = request == null ? null : _traces[request];
    return trace?.requestId ?? -1;
  }

  Duration _elapsedFor(http.BaseRequest? request) {
    final _RequestTrace? trace = request == null ? null : _traces[request];
    if (trace != null) {
      return DateTime.now().difference(trace.startedAt);
    }

    return Duration.zero;
  }

  String _formatRequestBody(http.BaseRequest request) {
    if (request is http.Request) {
      if (request.bodyBytes.isEmpty) {
        return '<empty>';
      }

      return _formatStructuredValue(utf8.decode(request.bodyBytes));
    }

    if (request is http.MultipartRequest) {
      final Map<String, dynamic> formData = <String, dynamic>{
        'fields': request.fields,
        if (request.files.isNotEmpty)
          'files': request.files
              .map(
                (http.MultipartFile file) => <String, dynamic>{
                  'field': file.field,
                  'filename': file.filename,
                  'length': file.length,
                  'content_type': file.contentType.toString(),
                },
              )
              .toList(growable: false),
      };

      return _formatStructuredValue(formData);
    }

    if (request is http.StreamedRequest) {
      return '<stream request opened>';
    }

    if (request.contentLength == 0) {
      return '<empty>';
    }

    return '<request body unavailable>';
  }

  String _formatResponseBody(http.BaseResponse response) {
    if (response is http.Response) {
      if (response.bodyBytes.isEmpty) {
        return '<empty>';
      }

      return _formatStructuredValue(utf8.decode(response.bodyBytes));
    }

    if (response is http.StreamedResponse) {
      return '<stream response opened>';
    }

    if (response.contentLength == 0) {
      return '<empty>';
    }

    return '<response body unavailable>';
  }

  String _formatStructuredValue(Object? value) {
    if (value == null) {
      return '<empty>';
    }

    if (value is Uint8List) {
      return '<binary ${value.length} bytes>';
    }

    if (value is String) {
      final String trimmed = value.trim();
      if (trimmed.isEmpty) {
        return '<empty>';
      }

      final Object? decoded = _tryDecodeJson(trimmed);
      if (decoded != null) {
        return _prettyJson(decoded);
      }

      return value;
    }

    return _prettyJson(value);
  }

  String _prettyJson(Object? value) {
    final Object? normalized = _normalizeValue(value);
    if (normalized is String) {
      return normalized;
    }

    return const JsonEncoder.withIndent('  ').convert(normalized);
  }

  Object? _normalizeValue(Object? value) {
    if (value == null || value is num || value is bool || value is String) {
      return value;
    }

    if (value is Uint8List) {
      return '<binary ${value.length} bytes>';
    }

    if (value is List<dynamic>) {
      return value.map(_normalizeValue).toList(growable: false);
    }

    if (value is Map<String, dynamic>) {
      return value.map(
        (String key, dynamic innerValue) =>
            MapEntry(key, _normalizeValue(innerValue)),
      );
    }

    if (value is Map<Object?, Object?>) {
      return value.map(
        (Object? key, Object? innerValue) =>
            MapEntry(key.toString(), _normalizeValue(innerValue)),
      );
    }

    return value.toString();
  }

  Object? _tryDecodeJson(String value) {
    if (!_looksLikeJson(value)) {
      return null;
    }

    try {
      return jsonDecode(value);
    } on FormatException {
      return null;
    }
  }

  bool _looksLikeJson(String value) {
    return (value.startsWith('{') && value.endsWith('}')) ||
        (value.startsWith('[') && value.endsWith(']'));
  }

  String? _authorizationPreview(Map<String, dynamic> headers) {
    for (final MapEntry<String, dynamic> entry in headers.entries) {
      if (entry.key.toLowerCase() != 'authorization') {
        continue;
      }

      final String rawValue = entry.value?.toString().trim() ?? '';
      if (rawValue.isEmpty) {
        return null;
      }

      if (rawValue.toLowerCase().startsWith('bearer ')) {
        return 'Bearer <redacted>';
      }

      return '<redacted>';
    }

    return null;
  }

  String _divider(String title) => '================ $title ================';

  String _dividerEnd() => '================================================';
}

class _RequestTrace {
  const _RequestTrace({required this.requestId, required this.startedAt});

  final int requestId;
  final DateTime startedAt;
}
