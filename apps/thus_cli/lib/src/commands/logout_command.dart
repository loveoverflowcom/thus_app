import 'dart:io';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';

import 'command_handler.dart';

class LogoutCommand implements CommandHandler {
  LogoutCommand(this._logout);

  final Logout _logout;

  @override
  String get command => '/logout';

  @override
  String get description => '/logout - clear local session';

  @override
  Future<void> handle(List<String> args) async {
    await _logout(const NoParams());
    stdout.writeln('Local session cleared.');
  }
}
