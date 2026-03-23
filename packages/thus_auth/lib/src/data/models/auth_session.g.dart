// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthSessionImpl _$AuthSessionImplFromJson(Map<String, dynamic> json) =>
    _$AuthSessionImpl(
      userId: json['userId'] as String,
      username: json['username'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      notificationToken: json['notificationToken'] as String,
      authenticatedAt: DateTime.parse(json['authenticatedAt'] as String),
    );

Map<String, dynamic> _$AuthSessionImplToJson(_$AuthSessionImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'notificationToken': instance.notificationToken,
      'authenticatedAt': instance.authenticatedAt.toIso8601String(),
    };
