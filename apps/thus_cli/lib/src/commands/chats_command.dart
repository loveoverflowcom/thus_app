import 'dart:io';

import 'package:thus_messaging/thus_messaging.dart';

import 'command_handler.dart';

class ChatsCommand implements CommandHandler {
  ChatsCommand(this._loadChatHistory);

  final LoadChatHistory _loadChatHistory;

  @override
  String get command => '/chats';

  @override
  String get description => '/chats [conversationId] — list cached chats or history for one thread';

  @override
  Future<void> handle(List<String> args) async {
    final conversationId = args.isEmpty ? 'general' : args.first;
    final history = await _loadChatHistory.call(conversationId);
    if (history.isEmpty) {
      stdout.writeln('No messages in $conversationId');
      return;
    }
    for (final message in history.take(20)) {
      stdout.writeln('[${message.timestamp.toIso8601String()}] ${message.senderId}: ${message.content}');
    }
  }
}
