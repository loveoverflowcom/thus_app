import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

import 'message.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  @HiveType(typeId: 3, adapterName: 'ChatAdapter')
  const factory Chat({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) List<String>? participantIds,
    @HiveField(3) Message? lastMessage,
    @HiveField(4) DateTime? updatedAt,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
