import 'package:web_socket/web_socket.dart';

Future<void> main() async {
  print('Connecting to WebSocket server...');

  final socket =
      await WebSocket.connect(Uri.parse('ws://127.0.0.1:9001'));

  print('Connected!');

  socket.events.listen((event) async {
    switch (event) {
      case TextDataReceived(text: final text):
        print('Received text: $text');

      case BinaryDataReceived(data: final data):
        print('Received binary: $data');

      case CloseReceived(code: final code, reason: final reason):
        print('Connection closed: $code [$reason]');
    }
  });

  // Gửi thử message
  socket.sendText('Hello from thus_messaging example 🚀');
}
