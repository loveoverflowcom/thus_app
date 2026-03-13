import 'dart:io';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'command_handler.dart';

class SendCommand implements CommandHandler {
  SendCommand(this._sendMessage, this._loadIdentity);

  final SendMessage _sendMessage;
  final LoadIdentity _loadIdentity;

  @override
  String get command => '/send';

  @override
  String get description => '/send <user> <message> — send message to a user';

  @override
  Future<void> handle(List<String> args) async {
    if (args.length < 2) {
      stdout.writeln('Usage: /send <user> <message>');
      return;
    }
    final identity = await _loadIdentity.call(const NoParams());
    if (identity == null) {
      stdout.writeln('Login first with /login <displayName>');
      return;
    }

    final receiverId = args.first;
    final content = args.sublist(1).join(' ');
    final message = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      senderId: identity.id,
      receiverId: receiverId,
      timestamp: DateTime.now().toUtc(),
      content: content,
      status: MessageStatus.sending,
      conversationId: receiverId,
    );
    final persisted = await _sendMessage.call(message);
    stdout.writeln('sent → ${persisted.receiverId}: ${persisted.content} [${persisted.status.name}]');
  }
}
