import 'dart:io';

import 'package:thus_messaging/thus_messaging.dart';

void main() {
  final Message message = Message(
    id: 'local-1',
    senderId: 'alice',
    receiverId: 'bob',
    timestamp: DateTime.utc(2026, 3, 19),
    content: 'hello from thus_messaging',
    status: MessageStatus.sent,
    conversationId: 'bob',
    source: 'example',
  );

  stdout.writeln(message.toJson());
}
