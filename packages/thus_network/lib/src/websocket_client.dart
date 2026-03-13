import 'dart:async';

import 'package:stream_transform/stream_transform.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient {
  WebSocketClient(this._channel);

  final WebSocketChannel _channel;

  Stream<dynamic> get stream => _channel.stream;

  /// Debounce outgoing messages to avoid flooding.
  Sink<dynamic> get sink => _channel.sink;

  Future<void> send(dynamic data) async {
    sink.add(data);
  }

  Stream<T> jsonStream<T>() => stream.map((event) => event as T);

  Future<void> close() async => _channel.sink.close();
}

WebSocketClient connectWebSocket(Uri uri) {
  final channel = WebSocketChannel.connect(uri);
  return WebSocketClient(channel);
}
