import 'dart:io';

import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'command_handler.dart';

class ChatsCommand implements CommandHandler {
  ChatsCommand(this._loadChats, this._loadChatHistory);

  final LoadChats _loadChats;
  final LoadChatHistory _loadChatHistory;

  @override
  String get command => '/chats';

  @override
  String get description =>
      '/chats [target_user_id] - list cached chats or one conversation';

  @override
  Future<void> handle(List<String> args) async {
    if (args.isEmpty) {
      final List<Chat> chats = await _loadChats(const NoParams());
      if (chats.isEmpty) {
        stdout.writeln('No cached chats yet.');
        return;
      }

      for (final Chat chat in chats) {
        stdout.writeln(
          '${chat.id} | ${chat.lastMessage?.content ?? 'No message'}',
        );
      }
      return;
    }

    final String conversationId = args.first;
    final List<Message> history = await _loadChatHistory(conversationId);
    if (history.isEmpty) {
      stdout.writeln('No messages in $conversationId');
      return;
    }

    for (final Message message in history.take(20)) {
      stdout.writeln(
        '[${message.timestamp.toIso8601String()}] ${message.senderId}: ${message.content}',
      );
    }
  }
}
