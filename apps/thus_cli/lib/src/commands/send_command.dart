import 'dart:io';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/command_help.dart';

class SendCommand extends CommandHandler {
  SendCommand(this._messageRepository, this._authRepository);

  static const CommandHelp helpInfo = CommandHelp(
    command: '/send',
    usage: '/send <target_user_id> <message>',
    summary: 'Send a message to another user.',
    examples: <String>[
      '/send <target_user_id> hello from thus',
      '/send <target_user_id> "hello from thus"',
    ],
  );

  final MessageRepository _messageRepository;
  final AuthRepository _authRepository;

  @override
  CommandHelp get help => helpInfo;

  @override
  Future<void> handle(List<String> args) async {
    if (args.length < 2) {
      stdout.writeln(formatHelp());
      return;
    }

    final sessionResult = await _authRepository.loadSession().run();
    final session = sessionResult.getOrElse((_) => null);
    if (session == null) {
      stdout.writeln('Login first with /login <username> <password>');
      return;
    }

    final result = await _messageRepository
        .send(
          receiverId: args.first,
          content: args.sublist(1).join(' '),
          source: 'thus_cli',
        )
        .run();

    result.match(
      (failure) => stdout.writeln('Send failed: $failure'),
      (persisted) => stdout.writeln(
        'sent -> ${persisted.receiverId}: ${persisted.content} [${persisted.status.name}]',
      ),
    );
  }
}
