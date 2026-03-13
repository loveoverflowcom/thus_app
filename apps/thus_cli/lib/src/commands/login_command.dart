import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

import 'command_handler.dart';

class LoginCommand implements CommandHandler {
  LoginCommand(this._generateKeyPair);

  final GenerateKeyPair _generateKeyPair;

  @override
  String get command => '/login';

  @override
  String get description => '/login <displayName> — generate and store identity';

  @override
  Future<void> handle(List<String> args) async {
    if (args.isEmpty) {
      stdout.writeln('Usage: /login <displayName>');
      return;
    }
    final displayName = args.join(' ');
    final identity = await _generateKeyPair.call(displayName);
    stdout.writeln('Authenticated as ${identity.displayName} (${identity.id})');
  }
}
