// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) {
  return _AuthSession.fromJson(json);
}

/// @nodoc
mixin _$AuthSession {
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  String get notificationToken => throw _privateConstructorUsedError;
  DateTime get authenticatedAt => throw _privateConstructorUsedError;

  /// Serializes this AuthSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthSessionCopyWith<AuthSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSessionCopyWith<$Res> {
  factory $AuthSessionCopyWith(
    AuthSession value,
    $Res Function(AuthSession) then,
  ) = _$AuthSessionCopyWithImpl<$Res, AuthSession>;
  @useResult
  $Res call({
    String userId,
    String username,
    String accessToken,
    String refreshToken,
    String notificationToken,
    DateTime authenticatedAt,
  });
}

/// @nodoc
class _$AuthSessionCopyWithImpl<$Res, $Val extends AuthSession>
    implements $AuthSessionCopyWith<$Res> {
  _$AuthSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? notificationToken = null,
    Object? authenticatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            accessToken: null == accessToken
                ? _value.accessToken
                : accessToken // ignore: cast_nullable_to_non_nullable
                      as String,
            refreshToken: null == refreshToken
                ? _value.refreshToken
                : refreshToken // ignore: cast_nullable_to_non_nullable
                      as String,
            notificationToken: null == notificationToken
                ? _value.notificationToken
                : notificationToken // ignore: cast_nullable_to_non_nullable
                      as String,
            authenticatedAt: null == authenticatedAt
                ? _value.authenticatedAt
                : authenticatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AuthSessionImplCopyWith<$Res>
    implements $AuthSessionCopyWith<$Res> {
  factory _$$AuthSessionImplCopyWith(
    _$AuthSessionImpl value,
    $Res Function(_$AuthSessionImpl) then,
  ) = __$$AuthSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String username,
    String accessToken,
    String refreshToken,
    String notificationToken,
    DateTime authenticatedAt,
  });
}

/// @nodoc
class __$$AuthSessionImplCopyWithImpl<$Res>
    extends _$AuthSessionCopyWithImpl<$Res, _$AuthSessionImpl>
    implements _$$AuthSessionImplCopyWith<$Res> {
  __$$AuthSessionImplCopyWithImpl(
    _$AuthSessionImpl _value,
    $Res Function(_$AuthSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? notificationToken = null,
    Object? authenticatedAt = null,
  }) {
    return _then(
      _$AuthSessionImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        accessToken: null == accessToken
            ? _value.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _value.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
        notificationToken: null == notificationToken
            ? _value.notificationToken
            : notificationToken // ignore: cast_nullable_to_non_nullable
                  as String,
        authenticatedAt: null == authenticatedAt
            ? _value.authenticatedAt
            : authenticatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthSessionImpl implements _AuthSession {
  const _$AuthSessionImpl({
    required this.userId,
    required this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.notificationToken,
    required this.authenticatedAt,
  });

  factory _$AuthSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthSessionImplFromJson(json);

  @override
  final String userId;
  @override
  final String username;
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final String notificationToken;
  @override
  final DateTime authenticatedAt;

  @override
  String toString() {
    return 'AuthSession(userId: $userId, username: $username, accessToken: $accessToken, refreshToken: $refreshToken, notificationToken: $notificationToken, authenticatedAt: $authenticatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSessionImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.notificationToken, notificationToken) ||
                other.notificationToken == notificationToken) &&
            (identical(other.authenticatedAt, authenticatedAt) ||
                other.authenticatedAt == authenticatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    username,
    accessToken,
    refreshToken,
    notificationToken,
    authenticatedAt,
  );

  /// Create a copy of AuthSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSessionImplCopyWith<_$AuthSessionImpl> get copyWith =>
      __$$AuthSessionImplCopyWithImpl<_$AuthSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthSessionImplToJson(this);
  }
}

abstract class _AuthSession implements AuthSession {
  const factory _AuthSession({
    required final String userId,
    required final String username,
    required final String accessToken,
    required final String refreshToken,
    required final String notificationToken,
    required final DateTime authenticatedAt,
  }) = _$AuthSessionImpl;

  factory _AuthSession.fromJson(Map<String, dynamic> json) =
      _$AuthSessionImpl.fromJson;

  @override
  String get userId;
  @override
  String get username;
  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  String get notificationToken;
  @override
  DateTime get authenticatedAt;

  /// Create a copy of AuthSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSessionImplCopyWith<_$AuthSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
