import 'dart:async';

import 'command_help.dart';

abstract class CommandHandler {
  CommandHelp get help;

  String get command => help.command;
  String get description => help.description;
  String get usage => help.usage;
  String get summary => help.summary;
  List<String> get examples => help.examples;

  String formatHelp() => help.formatDetails();

  Future<void> handle(List<String> args);
}
