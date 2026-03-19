import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

import 'command_handler.dart';

class LoginCommand implements CommandHandler {
  LoginCommand(this._login);

  final Login _login;

  @override
  String get command => '/login';

  @override
  String get description => '/login <username> <password> - sign in';

  @override
  Future<void> handle(List<String> args) async {
    if (args.length < 2) {
      stdout.writeln('Usage: /login <username> <password>');
      return;
    }

    final AuthSession session = await _login(
      AuthCredentials(
        username: args.first,
        password: args.sublist(1).join(' '),
      ),
    );

    stdout.writeln('Logged in as ${session.username} (${session.userId})');
  }
}
