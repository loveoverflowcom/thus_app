// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthFailure {

 int? get code; String get message; StackTrace get stackTrace;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'AuthFailure(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




/// Adds pattern-matching-related methods to [AuthFailure].
extension AuthFailurePatterns on AuthFailure {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthNetworkFailure value)?  network,TResult Function( AuthUnauthorizedFailure value)?  unauthorized,TResult Function( AuthStorageFailure value)?  storage,TResult Function( AuthOtherFailure value)?  other,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthNetworkFailure() when network != null:
return network(_that);case AuthUnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case AuthStorageFailure() when storage != null:
return storage(_that);case AuthOtherFailure() when other != null:
return other(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthNetworkFailure value)  network,required TResult Function( AuthUnauthorizedFailure value)  unauthorized,required TResult Function( AuthStorageFailure value)  storage,required TResult Function( AuthOtherFailure value)  other,}){
final _that = this;
switch (_that) {
case AuthNetworkFailure():
return network(_that);case AuthUnauthorizedFailure():
return unauthorized(_that);case AuthStorageFailure():
return storage(_that);case AuthOtherFailure():
return other(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthNetworkFailure value)?  network,TResult? Function( AuthUnauthorizedFailure value)?  unauthorized,TResult? Function( AuthStorageFailure value)?  storage,TResult? Function( AuthOtherFailure value)?  other,}){
final _that = this;
switch (_that) {
case AuthNetworkFailure() when network != null:
return network(_that);case AuthUnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case AuthStorageFailure() when storage != null:
return storage(_that);case AuthOtherFailure() when other != null:
return other(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? code,  String message,  StackTrace stackTrace)?  network,TResult Function( int? code,  String message,  StackTrace stackTrace)?  unauthorized,TResult Function( int? code,  String message,  StackTrace stackTrace)?  storage,TResult Function( int? code,  String message,  StackTrace stackTrace)?  other,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthNetworkFailure() when network != null:
return network(_that.code,_that.message,_that.stackTrace);case AuthUnauthorizedFailure() when unauthorized != null:
return unauthorized(_that.code,_that.message,_that.stackTrace);case AuthStorageFailure() when storage != null:
return storage(_that.code,_that.message,_that.stackTrace);case AuthOtherFailure() when other != null:
return other(_that.code,_that.message,_that.stackTrace);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? code,  String message,  StackTrace stackTrace)  network,required TResult Function( int? code,  String message,  StackTrace stackTrace)  unauthorized,required TResult Function( int? code,  String message,  StackTrace stackTrace)  storage,required TResult Function( int? code,  String message,  StackTrace stackTrace)  other,}) {final _that = this;
switch (_that) {
case AuthNetworkFailure():
return network(_that.code,_that.message,_that.stackTrace);case AuthUnauthorizedFailure():
return unauthorized(_that.code,_that.message,_that.stackTrace);case AuthStorageFailure():
return storage(_that.code,_that.message,_that.stackTrace);case AuthOtherFailure():
return other(_that.code,_that.message,_that.stackTrace);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? code,  String message,  StackTrace stackTrace)?  network,TResult? Function( int? code,  String message,  StackTrace stackTrace)?  unauthorized,TResult? Function( int? code,  String message,  StackTrace stackTrace)?  storage,TResult? Function( int? code,  String message,  StackTrace stackTrace)?  other,}) {final _that = this;
switch (_that) {
case AuthNetworkFailure() when network != null:
return network(_that.code,_that.message,_that.stackTrace);case AuthUnauthorizedFailure() when unauthorized != null:
return unauthorized(_that.code,_that.message,_that.stackTrace);case AuthStorageFailure() when storage != null:
return storage(_that.code,_that.message,_that.stackTrace);case AuthOtherFailure() when other != null:
return other(_that.code,_that.message,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class AuthNetworkFailure implements AuthFailure {
  const AuthNetworkFailure({required this.code, required this.message, required this.stackTrace});
  

@override final  int? code;
@override final  String message;
@override final  StackTrace stackTrace;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthNetworkFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'AuthFailure.network(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




/// @nodoc


class AuthUnauthorizedFailure implements AuthFailure {
  const AuthUnauthorizedFailure({required this.code, required this.message, required this.stackTrace});
  

@override final  int? code;
@override final  String message;
@override final  StackTrace stackTrace;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUnauthorizedFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'AuthFailure.unauthorized(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




/// @nodoc


class AuthStorageFailure implements AuthFailure {
  const AuthStorageFailure({required this.code, required this.message, required this.stackTrace});
  

@override final  int? code;
@override final  String message;
@override final  StackTrace stackTrace;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthStorageFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'AuthFailure.storage(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




/// @nodoc


class AuthOtherFailure implements AuthFailure {
  const AuthOtherFailure({required this.code, required this.message, required this.stackTrace});
  

@override final  int? code;
@override final  String message;
@override final  StackTrace stackTrace;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthOtherFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'AuthFailure.other(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




// dart format on
