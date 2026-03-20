import 'dart:io';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'command_handler.dart';
import 'command_help.dart';

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

    final AuthSession? session = await _authRepository.loadSession();
    if (session == null) {
      stdout.writeln('Login first with /login <username> <password>');
      return;
    }

    final Message persisted = await _messageRepository.send(
      toUserId: args.first,
      content: args.sublist(1).join(' '),
      source: 'thus_cli',
    );

    stdout.writeln(
      'sent -> ${persisted.receiverId}: ${persisted.content} [${persisted.status.name}]',
    );
  }
}
