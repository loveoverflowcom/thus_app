import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

import 'command_handler.dart';
import 'command_help.dart';

class LogoutCommand extends CommandHandler {
  LogoutCommand(this._authRepository);

  static const CommandHelp helpInfo = CommandHelp(
    command: '/logout',
    usage: '/logout',
    summary: 'Clear the locally stored session.',
    examples: <String>['/logout'],
  );

  final AuthRepository _authRepository;

  @override
  CommandHelp get help => helpInfo;

  @override
  Future<void> handle(List<String> args) async {
    await _authRepository.logout();
    stdout.writeln('Local session cleared.');
  }
}
