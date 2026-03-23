// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthFailure {
  int? get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  StackTrace get stackTrace => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? code, String message, StackTrace stackTrace)
    network,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    unauthorized,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    storage,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    other,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    network,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    storage,
    TResult? Function(int? code, String message, StackTrace stackTrace)? other,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? code, String message, StackTrace stackTrace)? network,
    TResult Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult Function(int? code, String message, StackTrace stackTrace)? storage,
    TResult Function(int? code, String message, StackTrace stackTrace)? other,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNetworkFailure value) network,
    required TResult Function(AuthUnauthorizedFailure value) unauthorized,
    required TResult Function(AuthStorageFailure value) storage,
    required TResult Function(AuthOtherFailure value) other,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNetworkFailure value)? network,
    TResult? Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult? Function(AuthStorageFailure value)? storage,
    TResult? Function(AuthOtherFailure value)? other,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNetworkFailure value)? network,
    TResult Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult Function(AuthStorageFailure value)? storage,
    TResult Function(AuthOtherFailure value)? other,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AuthNetworkFailureImpl implements AuthNetworkFailure {
  const _$AuthNetworkFailureImpl({
    required this.code,
    required this.message,
    required this.stackTrace,
  });

  @override
  final int? code;
  @override
  final String message;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'AuthFailure.network(code: $code, message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthNetworkFailureImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, message, stackTrace);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? code, String message, StackTrace stackTrace)
    network,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    unauthorized,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    storage,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    other,
  }) {
    return network(code, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    network,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    storage,
    TResult? Function(int? code, String message, StackTrace stackTrace)? other,
  }) {
    return network?.call(code, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? code, String message, StackTrace stackTrace)? network,
    TResult Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult Function(int? code, String message, StackTrace stackTrace)? storage,
    TResult Function(int? code, String message, StackTrace stackTrace)? other,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(code, message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNetworkFailure value) network,
    required TResult Function(AuthUnauthorizedFailure value) unauthorized,
    required TResult Function(AuthStorageFailure value) storage,
    required TResult Function(AuthOtherFailure value) other,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNetworkFailure value)? network,
    TResult? Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult? Function(AuthStorageFailure value)? storage,
    TResult? Function(AuthOtherFailure value)? other,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNetworkFailure value)? network,
    TResult Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult Function(AuthStorageFailure value)? storage,
    TResult Function(AuthOtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class AuthNetworkFailure implements AuthFailure {
  const factory AuthNetworkFailure({
    required final int? code,
    required final String message,
    required final StackTrace stackTrace,
  }) = _$AuthNetworkFailureImpl;

  @override
  int? get code;
  @override
  String get message;
  @override
  StackTrace get stackTrace;
}

/// @nodoc

class _$AuthUnauthorizedFailureImpl implements AuthUnauthorizedFailure {
  const _$AuthUnauthorizedFailureImpl({
    required this.code,
    required this.message,
    required this.stackTrace,
  });

  @override
  final int? code;
  @override
  final String message;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'AuthFailure.unauthorized(code: $code, message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthUnauthorizedFailureImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, message, stackTrace);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? code, String message, StackTrace stackTrace)
    network,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    unauthorized,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    storage,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    other,
  }) {
    return unauthorized(code, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    network,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    storage,
    TResult? Function(int? code, String message, StackTrace stackTrace)? other,
  }) {
    return unauthorized?.call(code, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? code, String message, StackTrace stackTrace)? network,
    TResult Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult Function(int? code, String message, StackTrace stackTrace)? storage,
    TResult Function(int? code, String message, StackTrace stackTrace)? other,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(code, message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNetworkFailure value) network,
    required TResult Function(AuthUnauthorizedFailure value) unauthorized,
    required TResult Function(AuthStorageFailure value) storage,
    required TResult Function(AuthOtherFailure value) other,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNetworkFailure value)? network,
    TResult? Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult? Function(AuthStorageFailure value)? storage,
    TResult? Function(AuthOtherFailure value)? other,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNetworkFailure value)? network,
    TResult Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult Function(AuthStorageFailure value)? storage,
    TResult Function(AuthOtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class AuthUnauthorizedFailure implements AuthFailure {
  const factory AuthUnauthorizedFailure({
    required final int? code,
    required final String message,
    required final StackTrace stackTrace,
  }) = _$AuthUnauthorizedFailureImpl;

  @override
  int? get code;
  @override
  String get message;
  @override
  StackTrace get stackTrace;
}

/// @nodoc

class _$AuthStorageFailureImpl implements AuthStorageFailure {
  const _$AuthStorageFailureImpl({
    required this.code,
    required this.message,
    required this.stackTrace,
  });

  @override
  final int? code;
  @override
  final String message;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'AuthFailure.storage(code: $code, message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStorageFailureImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, message, stackTrace);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? code, String message, StackTrace stackTrace)
    network,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    unauthorized,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    storage,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    other,
  }) {
    return storage(code, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    network,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    storage,
    TResult? Function(int? code, String message, StackTrace stackTrace)? other,
  }) {
    return storage?.call(code, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? code, String message, StackTrace stackTrace)? network,
    TResult Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult Function(int? code, String message, StackTrace stackTrace)? storage,
    TResult Function(int? code, String message, StackTrace stackTrace)? other,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(code, message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNetworkFailure value) network,
    required TResult Function(AuthUnauthorizedFailure value) unauthorized,
    required TResult Function(AuthStorageFailure value) storage,
    required TResult Function(AuthOtherFailure value) other,
  }) {
    return storage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNetworkFailure value)? network,
    TResult? Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult? Function(AuthStorageFailure value)? storage,
    TResult? Function(AuthOtherFailure value)? other,
  }) {
    return storage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNetworkFailure value)? network,
    TResult Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult Function(AuthStorageFailure value)? storage,
    TResult Function(AuthOtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (storage != null) {
      return storage(this);
    }
    return orElse();
  }
}

abstract class AuthStorageFailure implements AuthFailure {
  const factory AuthStorageFailure({
    required final int? code,
    required final String message,
    required final StackTrace stackTrace,
  }) = _$AuthStorageFailureImpl;

  @override
  int? get code;
  @override
  String get message;
  @override
  StackTrace get stackTrace;
}

/// @nodoc

class _$AuthOtherFailureImpl implements AuthOtherFailure {
  const _$AuthOtherFailureImpl({
    required this.code,
    required this.message,
    required this.stackTrace,
  });

  @override
  final int? code;
  @override
  final String message;
  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'AuthFailure.other(code: $code, message: $message, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthOtherFailureImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, message, stackTrace);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? code, String message, StackTrace stackTrace)
    network,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    unauthorized,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    storage,
    required TResult Function(int? code, String message, StackTrace stackTrace)
    other,
  }) {
    return other(code, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    network,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult? Function(int? code, String message, StackTrace stackTrace)?
    storage,
    TResult? Function(int? code, String message, StackTrace stackTrace)? other,
  }) {
    return other?.call(code, message, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? code, String message, StackTrace stackTrace)? network,
    TResult Function(int? code, String message, StackTrace stackTrace)?
    unauthorized,
    TResult Function(int? code, String message, StackTrace stackTrace)? storage,
    TResult Function(int? code, String message, StackTrace stackTrace)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(code, message, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthNetworkFailure value) network,
    required TResult Function(AuthUnauthorizedFailure value) unauthorized,
    required TResult Function(AuthStorageFailure value) storage,
    required TResult Function(AuthOtherFailure value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthNetworkFailure value)? network,
    TResult? Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult? Function(AuthStorageFailure value)? storage,
    TResult? Function(AuthOtherFailure value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthNetworkFailure value)? network,
    TResult Function(AuthUnauthorizedFailure value)? unauthorized,
    TResult Function(AuthStorageFailure value)? storage,
    TResult Function(AuthOtherFailure value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }
}

abstract class AuthOtherFailure implements AuthFailure {
  const factory AuthOtherFailure({
    required final int? code,
    required final String message,
    required final StackTrace stackTrace,
  }) = _$AuthOtherFailureImpl;

  @override
  int? get code;
  @override
  String get message;
  @override
  StackTrace get stackTrace;
}
