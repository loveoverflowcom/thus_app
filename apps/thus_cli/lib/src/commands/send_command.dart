import 'dart:io';

import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_messaging/thus_messaging.dart';

import 'command_handler.dart';

class SendCommand implements CommandHandler {
  SendCommand(this._sendMessage, this._loadSession);

  final SendMessage _sendMessage;
  final LoadSession _loadSession;

  @override
  String get command => '/send';

  @override
  String get description => '/send <target_user_id> <message> - send message';

  @override
  Future<void> handle(List<String> args) async {
    if (args.length < 2) {
      stdout.writeln('Usage: /send <target_user_id> <message>');
      return;
    }

    final AuthSession? session = await _loadSession(const NoParams());
    if (session == null) {
      stdout.writeln('Login first with /login <username> <password>');
      return;
    }

    final Message persisted = await _sendMessage(
      SendMessageParams(
        toUserId: args.first,
        content: args.sublist(1).join(' '),
        source: 'thus_cli',
      ),
    );

    stdout.writeln(
      'sent -> ${persisted.receiverId}: ${persisted.content} [${persisted.status.name}]',
    );
  }
}
