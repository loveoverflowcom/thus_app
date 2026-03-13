import 'dart:convert';

import 'package:dio/dio.dart';

class SseClient {
  SseClient(this._dio);

  final Dio _dio;

  /// Simple SSE stream using text/event-stream.
  Stream<String> listen(String path, {Map<String, dynamic>? headers}) async* {
    final response = await _dio.get<ResponseBody>(
      path,
      options: Options(responseType: ResponseType.stream, headers: headers ?? <String, dynamic>{}),
    );

    final stream = response.data?.stream.transform(utf8.decoder);
    if (stream != null) {
      yield* stream;
    }
  }
}
