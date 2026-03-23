import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thus_core/thus_core.dart';

import 'sse_event.dart';

class SseClient {
  SseClient({
    required String baseUrl,
    required http.Client client,
    required AppLogger logger,
  }) : _baseUri = Uri.parse(baseUrl),
       _client = client,
       _logger = logger;

  static const Duration _connectTimeout = Duration(seconds: 10);

  final Uri _baseUri;
  final http.Client _client;
  final AppLogger _logger;

  Stream<SseEvent> listen(
    String path, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async* {
    final Uri uri = _buildUri(path, query: query);
    final http.Request request = http.Request('GET', uri)
      ..headers.addAll(<String, String>{
        'Accept': 'text/event-stream',
        ...?headers,
      });

    final http.StreamedResponse response;
    try {
      response = await _client.send(request).timeout(_connectTimeout);
    } on TimeoutException catch (error, stackTrace) {
      _logger.log(
        'SSE GET $uri timed out.',
        level: LogLevel.error,
        error: error,
        stackTrace: stackTrace,
      );
      throw Exception('SSE GET $uri timed out.');
    } on http.ClientException catch (error, stackTrace) {
      _logger.log(
        'SSE GET $uri failed.',
        level: LogLevel.error,
        error: error,
        stackTrace: stackTrace,
      );
      throw Exception('SSE GET $uri failed: ${error.message}');
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      final String body = await response.stream.bytesToString();
      throw Exception('SSE ${response.statusCode} GET $uri: $body');
    }

    final Stream<String> lines = utf8.decoder
        .bind(response.stream)
        .transform(const LineSplitter());

    String eventName = 'message';
    String? eventId;
    final List<String> dataLines = <String>[];

    await for (final String line in lines) {
      _logger.log('SSE raw line: ${line.isEmpty ? '<empty>' : line}', level: .debug);

      if (line.isEmpty) {
        final SseEvent? event = _buildEvent(
          eventName: eventName,
          eventId: eventId,
          dataLines: dataLines,
        );

        if (event != null) {
          _logger.log('SSE yielding event: ${event.event}', level: .debug);
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

    _logger.log('SSE stream ended for $uri', level: .warning);

    final SseEvent? trailingEvent = _buildEvent(
      eventName: eventName,
      eventId: eventId,
      dataLines: dataLines,
    );

    if (trailingEvent != null) {
      yield trailingEvent;
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
