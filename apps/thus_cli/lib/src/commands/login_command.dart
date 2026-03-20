import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

import 'command_handler.dart';
import 'command_help.dart';

class LoginCommand extends CommandHandler {
  LoginCommand(this._authRepository);

  static const CommandHelp helpInfo = CommandHelp(
    command: '/login',
    usage: '/login <username> <password>',
    summary: 'Sign in with an existing account.',
    examples: <String>['/login alice super-secret-password'],
  );

  final AuthRepository _authRepository;

  @override
  CommandHelp get help => helpInfo;

  @override
  Future<void> handle(List<String> args) async {
    if (args.length < 2) {
      stdout.writeln(formatHelp());
      return;
    }

    final AuthSession session = await _authRepository.login(
      AuthCredentials(
        username: args.first,
        password: args.sublist(1).join(' '),
      ),
    );

    stdout.writeln('Logged in as ${session.username} (${session.userId})');
  }
}
