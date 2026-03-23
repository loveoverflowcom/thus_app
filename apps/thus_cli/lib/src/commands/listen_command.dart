import 'dart:io';

import 'package:thus_messaging/thus_messaging.dart';

import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/command_help.dart';

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

    await for (final event in _messageRepository.incomingMessages) {
      final received = event as MessageReceived;
      stdout.writeln(
        '[incoming] conversationId: ${received.conversationId} | messageId: ${received.messageId}',
      );
    }
  }
}
