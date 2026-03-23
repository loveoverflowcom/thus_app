import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:thus_messaging/src/data/models/message.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    required String title,
    required List<String> participantIds,
    Message? lastMessage,
    DateTime? updatedAt,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
