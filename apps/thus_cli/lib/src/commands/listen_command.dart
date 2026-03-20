import 'dart:io';

import 'package:thus_messaging/thus_messaging.dart';

import 'command_handler.dart';
import 'command_help.dart';

class ListenCommand extends CommandHandler {
  ListenCommand(this._messageRepository);

  static const CommandHelp helpInfo = CommandHelp(
    command: '/listen',
    usage: '/listen',
    summary: 'Keep the SSE stream open and print incoming messages.',
    examples: <String>['/listen'],
  );

  final MessageRepository _messageRepository;

  @override
  CommandHelp get help => helpInfo;

  @override
  Future<void> handle(List<String> args) async {
    stdout.writeln(
      'Listening for incoming SSE messages. Press Ctrl+C to stop.',
    );

    final Stream<Message> stream = _messageRepository.incoming();
    await for (final Message message in stream) {
      stdout.writeln(
        '[${message.timestamp.toIso8601String()}] ${message.senderId} -> ${message.receiverId}: ${message.content}',
      );
    }
  }
}
