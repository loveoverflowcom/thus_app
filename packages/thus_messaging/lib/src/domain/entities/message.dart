import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:thus_messaging/src/domain/entities/message_status.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String senderId,
    required String receiverId,
    required DateTime timestamp,
    required String content,
    required MessageStatus status,
    required String conversationId,
    @Default('chat.message') String eventName,
    String? source,
    @Default(false) bool isIncoming,
    String? remoteEventId,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
