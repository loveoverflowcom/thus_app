import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/command_help.dart';

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

    final result = await _authRepository
        .register(
          username: args.first,
          password: args.sublist(1).join(' '),
        )
        .run();

    result.match(
      (failure) => stdout.writeln('Registration failed: $failure'),
      (session) => stdout
          .writeln('Registered as ${session.username} (${session.userId})'),
    );
  }
}
