import 'dart:io';

import 'package:thus_auth/thus_auth.dart';

import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/command_help.dart';

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
    final result = await _authRepository.logout().run();
    result.match(
      (failure) => stdout.writeln('Logout failed: $failure'),
      (_) => stdout.writeln('Local session cleared.'),
    );
  }
}
