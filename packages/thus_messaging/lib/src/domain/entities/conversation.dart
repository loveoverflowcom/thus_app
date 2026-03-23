import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:thus_messaging/src/domain/entities/message.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required List<Message> messages,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}
