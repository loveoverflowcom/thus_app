class CommandHelp {
  const CommandHelp({
    required this.command,
    required this.usage,
    required this.summary,
    this.examples = const <String>[],
  });

  final String command;
  final String usage;
  final String summary;
  final List<String> examples;

  String get description => '$usage - $summary';

  String formatDetails() {
    final StringBuffer buffer = StringBuffer()
      ..writeln('Command: $command')
      ..writeln('Usage: $usage')
      ..writeln(summary);

    if (examples.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('Examples:');
      for (final String example in examples) {
        buffer.writeln('  $example');
      }
    }

    return buffer.toString().trimRight();
  }
}
