import 'package:thus_core/thus_core.dart';
import 'package:thus_network/thus_network.dart';

import 'package:thus_auth/src/data/models/auth_credentials.dart';
import 'package:thus_auth/src/data/models/auth_session.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource({
    required RestClient restClient,
    required AppLogger logger,
  }) : _restClient = restClient,
       _logger = logger;

  final RestClient _restClient;
  final AppLogger _logger;

  Future<AuthSession> login(AuthCredentials credentials) async {
    return _authenticate(
      path: AppConstants.authLoginPath,
      credentials: credentials,
    );
  }

  Future<AuthSession> register(AuthCredentials credentials) async {
    return _authenticate(
      path: AppConstants.authRegisterPath,
      credentials: credentials,
    );
  }

  Future<AuthSession> refreshSession(AuthSession currentSession) async {
    final Map<String, dynamic>? payload = await _restClient.postJson(
      AppConstants.authRefreshPath,
      data: <String, dynamic>{'refresh_token': currentSession.refreshToken},
    );

    return _mapSession(
      payload,
      fallbackUsername: currentSession.username,
      fallbackUserId: currentSession.userId,
    );
  }

  Future<AuthSession> _authenticate({
    required String path,
    required AuthCredentials credentials,
  }) async {
    final Map<String, dynamic>? payload = await _restClient.postJson(
      path,
      data: <String, dynamic>{
        'username': credentials.username,
        'password': credentials.password,
      },
    );

    return _mapSession(payload, fallbackUsername: credentials.username);
  }

  AuthSession _mapSession(
    Map<String, dynamic>? payload, {
    required String fallbackUsername,
    String? fallbackUserId,
  }) {
    if (payload == null) {
      throw const FormatException('Auth response body is empty.');
    }

    final Map<String, dynamic> tokens = _castMap(payload['tokens']);
    final String? accessToken = _stringValue(tokens['access_token']);
    final String? refreshToken = _stringValue(tokens['refresh_token']);
    final String? notificationToken = _stringValue(
      tokens['notification_token'],
    );
    final String? userId = _stringValue(payload['user_id']) ?? fallbackUserId;

    if (accessToken == null ||
        refreshToken == null ||
        notificationToken == null ||
        userId == null) {
      _logger.log('Invalid auth response: $payload', level: LogLevel.error);
      throw const FormatException('Auth response is missing token fields.');
    }

    return AuthSession(
      userId: userId,
      username: fallbackUsername,
      accessToken: accessToken,
      refreshToken: refreshToken,
      notificationToken: notificationToken,
      authenticatedAt: DateTime.now().toUtc(),
    );
  }

  Map<String, dynamic> _castMap(Object? rawValue) {
    if (rawValue is Map<String, dynamic>) {
      return rawValue;
    }

    if (rawValue is Map<Object?, Object?>) {
      return rawValue.map(
        (Object? key, Object? value) => MapEntry(key.toString(), value),
      );
    }

    return <String, dynamic>{};
  }

  String? _stringValue(Object? rawValue) {
    if (rawValue == null) {
      return null;
    }

    final String value = rawValue.toString();
    return value.isEmpty ? null : value;
  }
}
