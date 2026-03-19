import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

import 'command_handler.dart';

class RegisterCommand implements CommandHandler {
  RegisterCommand(this._registerAccount);

  final RegisterAccount _registerAccount;

  @override
  String get command => '/register';

  @override
  String get description => '/register <username> <password> - create account';

  @override
  Future<void> handle(List<String> args) async {
    if (args.length < 2) {
      stdout.writeln('Usage: /register <username> <password>');
      return;
    }

    final AuthSession session = await _registerAccount(
      AuthCredentials(
        username: args.first,
        password: args.sublist(1).join(' '),
      ),
    );

    stdout.writeln('Registered as ${session.username} (${session.userId})');
  }
}
