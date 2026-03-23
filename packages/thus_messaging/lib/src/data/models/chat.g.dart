// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  participantIds: (json['participantIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  lastMessage: json['lastMessage'] == null
      ? null
      : Message.fromJson(json['lastMessage'] as Map<String, dynamic>),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ChatImplToJson(_$ChatImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'participantIds': instance.participantIds,
      'lastMessage': instance.lastMessage,
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
