import 'dart:io';

import 'package:thus_messaging/thus_messaging.dart';

import 'command_handler.dart';
import 'command_help.dart';

class ChatsCommand extends CommandHandler {
  ChatsCommand(this._messageRepository);

  static const CommandHelp helpInfo = CommandHelp(
    command: '/chats',
    usage: '/chats [conversation_id]',
    summary: 'List cached chats or print one cached conversation.',
    examples: <String>['/chats', '/chats <conversation_id>'],
  );

  final MessageRepository _messageRepository;

  @override
  CommandHelp get help => helpInfo;

  @override
  Future<void> handle(List<String> args) async {
    if (args.isEmpty) {
      final List<Chat> chats = await _messageRepository.loadChats();
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
    final List<Message> history = await _messageRepository.loadHistory(
      conversationId,
    );
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
