import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import 'sse_event.dart';

class SseClient {
  SseClient(this._dio);

  final Dio _dio;

  Stream<SseEvent> listen(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async* {
    final Response<ResponseBody> response = await _dio.get<ResponseBody>(
      path,
      queryParameters: query,
      options: Options(
        responseType: ResponseType.stream,
        headers: <String, String>{'Accept': 'text/event-stream', ...?headers},
      ),
    );

    final Stream<String>? lines = response.data == null
        ? null
        : utf8.decoder
              .bind(response.data!.stream)
              .transform(const LineSplitter());
    if (lines == null) {
      return;
    }

    String eventName = 'message';
    String? eventId;
    final List<String> dataLines = <String>[];

    await for (final String line in lines) {
      if (line.isEmpty) {
        final SseEvent? event = _buildEvent(
          eventName: eventName,
          eventId: eventId,
          dataLines: dataLines,
        );

        if (event != null) {
          yield event;
        }

        eventName = 'message';
        eventId = null;
        dataLines.clear();
        continue;
      }

      if (line.startsWith(':')) {
        continue;
      }

      final int separatorIndex = line.indexOf(':');
      final String field = separatorIndex == -1
          ? line
          : line.substring(0, separatorIndex);
      String value = separatorIndex == -1
          ? ''
          : line.substring(separatorIndex + 1);

      if (value.startsWith(' ')) {
        value = value.substring(1);
      }

      switch (field) {
        case 'event':
          eventName = value;
        case 'data':
          dataLines.add(value);
        case 'id':
          eventId = value;
        default:
          break;
      }
    }

    final SseEvent? trailingEvent = _buildEvent(
      eventName: eventName,
      eventId: eventId,
      dataLines: dataLines,
    );

    if (trailingEvent != null) {
      yield trailingEvent;
    }
  }

  SseEvent? _buildEvent({
    required String eventName,
    required String? eventId,
    required List<String> dataLines,
  }) {
    if (dataLines.isEmpty) {
      return null;
    }

    return SseEvent(event: eventName, data: dataLines.join('\n'), id: eventId);
  }
}
