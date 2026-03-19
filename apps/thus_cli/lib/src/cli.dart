import 'dart:async';
import 'dart:io';

import 'commands/command_handler.dart';

class Cli {
  Cli(this._handlers);

  final List<CommandHandler> _handlers;

  Map<String, CommandHandler> get _handlerMap => {
    for (final h in _handlers) h.command: h,
  };

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
    final tokens = raw.split(' ');
    final command = tokens.first;
    final args = tokens.skip(1).toList();
    final handler = _handlerMap[command];
    if (handler == null) {
      stdout.writeln('Unknown command: $command');
      _printHelp();
      return;
    }

    try {
      await handler.handle(args);
    } on Object catch (error) {
      stdout.writeln('Command failed: $error');
    }
  }

  void _printHelp() {
    stdout.writeln('Available commands:');
    for (final handler in _handlers) {
      stdout.writeln('  ${handler.description}');
    }
    stdout.writeln('  /exit - quit CLI');
  }
}
