import 'dart:async';

abstract class CommandHandler {
  String get command;
  String get description;
  Future<void> handle(List<String> args);
}
