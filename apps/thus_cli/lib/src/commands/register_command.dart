import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

import 'command_handler.dart';
import 'command_help.dart';

class RegisterCommand extends CommandHandler {
  RegisterCommand(this._authRepository);

  static const CommandHelp helpInfo = CommandHelp(
    command: '/register',
    usage: '/register <username> <password>',
    summary: 'Create a new account and persist the session locally.',
    examples: <String>['/register alice super-secret-password'],
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

    final AuthSession session = await _authRepository.register(
      AuthCredentials(
        username: args.first,
        password: args.sublist(1).join(' '),
      ),
    );

    stdout.writeln('Registered as ${session.username} (${session.userId})');
  }
}
