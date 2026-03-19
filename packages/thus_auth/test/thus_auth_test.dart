import 'package:test/test.dart';
import 'package:thus_auth/thus_auth.dart';

void main() {
  group('AuthSession', () {
    test('serializes to and from json', () {
      final AuthSession session = AuthSession(
        userId: 'user-1',
        username: 'alice',
        accessToken: 'access',
        refreshToken: 'refresh',
        notificationToken: 'notify',
        authenticatedAt: DateTime.utc(2026, 3, 19),
      );

      final Map<String, dynamic> json = session.toJson();
      final AuthSession restored = AuthSession.fromJson(json);

      expect(restored, session);
    });
  });
}
