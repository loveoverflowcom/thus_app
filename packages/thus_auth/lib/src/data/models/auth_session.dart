import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String userId,
    required String username,
    required String accessToken,
    required String refreshToken,
    required String notificationToken,
    required DateTime authenticatedAt,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}
