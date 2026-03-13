import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

import 'message_status.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  @HiveType(typeId: 2, adapterName: 'MessageAdapter')
  const factory Message({
    @HiveField(0) required String id,
    @HiveField(1) required String senderId,
    @HiveField(2) required String receiverId,
    @HiveField(3) required DateTime timestamp,
    @HiveField(4) required String content,
    @HiveField(5) @JsonKey(defaultValue: MessageStatus.sending) required MessageStatus status,
    @HiveField(6) String? conversationId,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}
