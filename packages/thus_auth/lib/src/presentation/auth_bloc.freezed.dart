// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String username, String password) loginSubmitted,
    required TResult Function(String username, String password)
    registerSubmitted,
    required TResult Function() refreshRequested,
    required TResult Function() logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String username, String password)? loginSubmitted,
    TResult? Function(String username, String password)? registerSubmitted,
    TResult? Function()? refreshRequested,
    TResult? Function()? logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String username, String password)? loginSubmitted,
    TResult Function(String username, String password)? registerSubmitted,
    TResult Function()? refreshRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'AuthEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String username, String password) loginSubmitted,
    required TResult Function(String username, String password)
    registerSubmitted,
    required TResult Function() refreshRequested,
    required TResult Function() logoutRequested,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String username, String password)? loginSubmitted,
    TResult? Function(String username, String password)? registerSubmitted,
    TResult? Function()? refreshRequested,
    TResult? Function()? logoutRequested,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String username, String password)? loginSubmitted,
    TResult Function(String username, String password)? registerSubmitted,
    TResult Function()? refreshRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements AuthEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc

class _$LoginSubmittedImpl implements _LoginSubmitted {
  const _$LoginSubmittedImpl({required this.username, required this.password});

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.loginSubmitted(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginSubmittedImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String username, String password) loginSubmitted,
    required TResult Function(String username, String password)
    registerSubmitted,
    required TResult Function() refreshRequested,
    required TResult Function() logoutRequested,
  }) {
    return loginSubmitted(username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String username, String password)? loginSubmitted,
    TResult? Function(String username, String password)? registerSubmitted,
    TResult? Function()? refreshRequested,
    TResult? Function()? logoutRequested,
  }) {
    return loginSubmitted?.call(username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String username, String password)? loginSubmitted,
    TResult Function(String username, String password)? registerSubmitted,
    TResult Function()? refreshRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginSubmitted != null) {
      return loginSubmitted(username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return loginSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return loginSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (loginSubmitted != null) {
      return loginSubmitted(this);
    }
    return orElse();
  }
}

abstract class _LoginSubmitted implements AuthEvent {
  const factory _LoginSubmitted({
    required final String username,
    required final String password,
  }) = _$LoginSubmittedImpl;

  String get username;
  String get password;
}

/// @nodoc

class _$RegisterSubmittedImpl implements _RegisterSubmitted {
  const _$RegisterSubmittedImpl({
    required this.username,
    required this.password,
  });

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.registerSubmitted(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterSubmittedImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String username, String password) loginSubmitted,
    required TResult Function(String username, String password)
    registerSubmitted,
    required TResult Function() refreshRequested,
    required TResult Function() logoutRequested,
  }) {
    return registerSubmitted(username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String username, String password)? loginSubmitted,
    TResult? Function(String username, String password)? registerSubmitted,
    TResult? Function()? refreshRequested,
    TResult? Function()? logoutRequested,
  }) {
    return registerSubmitted?.call(username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String username, String password)? loginSubmitted,
    TResult Function(String username, String password)? registerSubmitted,
    TResult Function()? refreshRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (registerSubmitted != null) {
      return registerSubmitted(username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return registerSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return registerSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (registerSubmitted != null) {
      return registerSubmitted(this);
    }
    return orElse();
  }
}

abstract class _RegisterSubmitted implements AuthEvent {
  const factory _RegisterSubmitted({
    required final String username,
    required final String password,
  }) = _$RegisterSubmittedImpl;

  String get username;
  String get password;
}

/// @nodoc

class _$RefreshRequestedImpl implements _RefreshRequested {
  const _$RefreshRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.refreshRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String username, String password) loginSubmitted,
    required TResult Function(String username, String password)
    registerSubmitted,
    required TResult Function() refreshRequested,
    required TResult Function() logoutRequested,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String username, String password)? loginSubmitted,
    TResult? Function(String username, String password)? registerSubmitted,
    TResult? Function()? refreshRequested,
    TResult? Function()? logoutRequested,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String username, String password)? loginSubmitted,
    TResult Function(String username, String password)? registerSubmitted,
    TResult Function()? refreshRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class _RefreshRequested implements AuthEvent {
  const factory _RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc

class _$LogoutRequestedImpl implements _LogoutRequested {
  const _$LogoutRequestedImpl();

  @override
  String toString() {
    return 'AuthEvent.logoutRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LogoutRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String username, String password) loginSubmitted,
    required TResult Function(String username, String password)
    registerSubmitted,
    required TResult Function() refreshRequested,
    required TResult Function() logoutRequested,
  }) {
    return logoutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String username, String password)? loginSubmitted,
    TResult? Function(String username, String password)? registerSubmitted,
    TResult? Function()? refreshRequested,
    TResult? Function()? logoutRequested,
  }) {
    return logoutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String username, String password)? loginSubmitted,
    TResult Function(String username, String password)? registerSubmitted,
    TResult Function()? refreshRequested,
    TResult Function()? logoutRequested,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_LoginSubmitted value) loginSubmitted,
    required TResult Function(_RegisterSubmitted value) registerSubmitted,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_LogoutRequested value) logoutRequested,
  }) {
    return logoutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_LoginSubmitted value)? loginSubmitted,
    TResult? Function(_RegisterSubmitted value)? registerSubmitted,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_LogoutRequested value)? logoutRequested,
  }) {
    return logoutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_LoginSubmitted value)? loginSubmitted,
    TResult Function(_RegisterSubmitted value)? registerSubmitted,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_LogoutRequested value)? logoutRequested,
    required TResult orElse(),
  }) {
    if (logoutRequested != null) {
      return logoutRequested(this);
    }
    return orElse();
  }
}

abstract class _LogoutRequested implements AuthEvent {
  const factory _LogoutRequested() = _$LogoutRequestedImpl;
}

/// @nodoc
mixin _$AuthState {
  AuthStatus get status => throw _privateConstructorUsedError;
  AuthSession? get session => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({AuthStatus status, AuthSession? session, String? message});

  $AuthSessionCopyWith<$Res>? get session;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? session = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as AuthStatus,
            session: freezed == session
                ? _value.session
                : session // ignore: cast_nullable_to_non_nullable
                      as AuthSession?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthSessionCopyWith<$Res>? get session {
    if (_value.session == null) {
      return null;
    }

    return $AuthSessionCopyWith<$Res>(_value.session!, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
    _$AuthStateImpl value,
    $Res Function(_$AuthStateImpl) then,
  ) = __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthStatus status, AuthSession? session, String? message});

  @override
  $AuthSessionCopyWith<$Res>? get session;
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
    _$AuthStateImpl _value,
    $Res Function(_$AuthStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? session = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _$AuthStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
        session: freezed == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                  as AuthSession?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl({
    this.status = AuthStatus.initial,
    this.session,
    this.message,
  });

  @override
  @JsonKey()
  final AuthStatus status;
  @override
  final AuthSession? session;
  @override
  final String? message;

  @override
  String toString() {
    return 'AuthState(status: $status, session: $session, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, session, message);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState({
    final AuthStatus status,
    final AuthSession? session,
    final String? message,
  }) = _$AuthStateImpl;

  @override
  AuthStatus get status;
  @override
  AuthSession? get session;
  @override
  String? get message;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
