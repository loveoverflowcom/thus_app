import 'dart:io';

import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'command_handler.dart';

class ListenCommand implements CommandHandler {
  ListenCommand(this._receiveMessage);

  final ReceiveMessage _receiveMessage;

  @override
  String get command => '/listen';

  @override
  String get description =>
      '/listen - keep SSE open and print incoming messages';

  @override
  Future<void> handle(List<String> args) async {
    stdout.writeln(
      'Listening for incoming SSE messages. Press Ctrl+C to stop.',
    );

    final Stream<Message> stream = await _receiveMessage(const NoParams());
    await for (final Message message in stream) {
      stdout.writeln(
        '[${message.timestamp.toIso8601String()}] ${message.senderId} -> ${message.receiverId}: ${message.content}',
      );
    }
  }
}
