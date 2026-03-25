// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: json['id'] as String,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  content: json['content'] as String,
  status: $enumDecode(_$MessageStatusEnumMap, json['status']),
  conversationId: json['conversationId'] as String,
  eventName: json['eventName'] as String? ?? 'chat.message',
  source: json['source'] as String?,
  isIncoming: json['isIncoming'] as bool? ?? false,
  remoteEventId: json['remoteEventId'] as String?,
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'timestamp': instance.timestamp.toIso8601String(),
  'content': instance.content,
  'status': _$MessageStatusEnumMap[instance.status]!,
  'conversationId': instance.conversationId,
  'eventName': instance.eventName,
  'source': instance.source,
  'isIncoming': instance.isIncoming,
  'remoteEventId': instance.remoteEventId,
};

const _$MessageStatusEnumMap = {
  MessageStatus.sending: 'sending',
  MessageStatus.sent: 'sent',
  MessageStatus.delivered: 'delivered',
  MessageStatus.read: 'read',
};
