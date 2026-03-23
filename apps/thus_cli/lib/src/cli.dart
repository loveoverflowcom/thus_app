import 'dart:async';
import 'dart:io';

import 'package:thus_cli/src/commands/command_handler.dart';
import 'package:thus_cli/src/commands/command_help.dart';

class Cli {
  Cli(this._handlers);

  final List<CommandHandler> _handlers;

  static const String _helpCommand = 'help';
  static const String _helpSlashCommand = '/help';
  static const List<String> _helpFlags = <String>['-h', '--help'];

  Map<String, CommandHandler> get _handlerMap => {
    for (final h in _handlers) h.command: h,
  };

  Iterable<CommandHelp> get _commandHelps => _handlers.map((h) => h.help);

  static bool isStandaloneHelpRequest(
    List<String> args,
    Iterable<CommandHelp> commandHelps,
  ) => standaloneHelpTarget(args, commandHelps) != null;

  static String? standaloneHelpTarget(
    List<String> args,
    Iterable<CommandHelp> commandHelps,
  ) {
    if (args.isEmpty) {
      return null;
    }

    final String first = args.first;
    if (args.length == 1 && (_isHelpToken(first) || _isHelpCommand(first))) {
      return '';
    }

    if ((_isHelpToken(first) || _isHelpCommand(first)) && args.length == 2) {
      return _resolveHelpTarget(args[1], commandHelps) ?? '';
    }

    if (args.length == 2 && _isHelpToken(args[1])) {
      return _resolveHelpTarget(first, commandHelps) ?? '';
    }

    return null;
  }

  Future<void> run(List<String> args) async {
    if (args.isNotEmpty) {
      await _dispatch(args.join(' '));
      return;
    }

    _printHelp();
    stdout.write('thus> ');
    await for (final line in stdin.transform(const SystemEncoding().decoder)) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) {
        stdout.write('thus> ');
        continue;
      }
      if (trimmed == '/exit') break;
      await _dispatch(trimmed);
      stdout.write('thus> ');
    }
  }

  Future<void> _dispatch(String raw) async {
    final List<String> tokens = raw
        .trim()
        .split(RegExp(r'\s+'))
        .where((String token) => token.isNotEmpty)
        .toList();
    if (tokens.isEmpty) {
      return;
    }

    final command = tokens.first;
    final args = tokens.skip(1).toList();
    if (_isHelpToken(command) || _isHelpCommand(command)) {
      _printHelpFor(args);
      return;
    }

    final handler = _handlerMap[command];
    if (handler == null) {
      stdout.writeln('Unknown command: $command');
      _printHelp();
      return;
    }

    if (args.length == 1 && _isHelpToken(args.first)) {
      stdout.writeln(handler.formatHelp());
      return;
    }

    try {
      await handler.handle(args);
    } on Object catch (error) {
      stdout.writeln('Command failed: $error');
    }
  }

  void _printHelp() {
    stdout.writeln(formatGeneralHelp(_commandHelps));
  }

  void _printHelpFor(List<String> args) {
    if (args.isEmpty) {
      _printHelp();
      return;
    }

    final String command = args.first;
    final CommandHandler? handler = _handlerMap[command];
    if (handler == null) {
      stdout.writeln('Unknown command: $command');
      _printHelp();
      return;
    }

    stdout.writeln(handler.formatHelp());
  }

  static String formatGeneralHelp(Iterable<CommandHelp> commandHelps) {
    final StringBuffer buffer = StringBuffer()
      ..writeln('Thus CLI')
      ..writeln()
      ..writeln('Usage:')
      ..writeln('  dart run bin/thus_cli.dart [options]')
      ..writeln('  dart run bin/thus_cli.dart <command> [arguments]')
      ..writeln('  dart run bin/thus_cli.dart')
      ..writeln()
      ..writeln('Options:')
      ..writeln('  -h, --help                  Show this help message.')
      ..writeln()
      ..writeln('Commands:');

    for (final CommandHelp commandHelp in commandHelps) {
      buffer.writeln('  ${commandHelp.description}');
    }

    buffer
      ..writeln('  help [command] - Show help for all commands or one command.')
      ..writeln('  /exit - quit CLI interactive mode')
      ..writeln()
      ..writeln('Examples:')
      ..writeln('  dart run bin/thus_cli.dart --help')
      ..writeln(
        '  dart run bin/thus_cli.dart /login alice super-secret-password',
      )
      ..writeln('  dart run bin/thus_cli.dart /send <target_user_id> "hello"')
      ..writeln('  dart run bin/thus_cli.dart help /send')
      ..writeln()
      ..writeln('Environment:')
      ..writeln('  THUS_BASE_URL  Override the backend base URL.');

    return buffer.toString().trimRight();
  }

  static bool _isHelpToken(String token) => _helpFlags.contains(token);

  static bool _isHelpCommand(String token) =>
      token == _helpCommand || token == _helpSlashCommand;

  static String? _resolveHelpTarget(
    String token,
    Iterable<CommandHelp> commandHelps,
  ) {
    for (final CommandHelp commandHelp in commandHelps) {
      if (commandHelp.command == token) {
        return token;
      }
    }
    return null;
  }
}
