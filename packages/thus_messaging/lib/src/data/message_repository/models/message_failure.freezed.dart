// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MessageFailure {

 int? get code; String get message; StackTrace get stackTrace;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'MessageFailure(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




/// Adds pattern-matching-related methods to [MessageFailure].
extension MessageFailurePatterns on MessageFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MessageNetworkFailure value)?  network,TResult Function( MessageStorageFailure value)?  storage,TResult Function( MessageOtherFailure value)?  other,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MessageNetworkFailure() when network != null:
return network(_that);case MessageStorageFailure() when storage != null:
return storage(_that);case MessageOtherFailure() when other != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MessageNetworkFailure value)  network,required TResult Function( MessageStorageFailure value)  storage,required TResult Function( MessageOtherFailure value)  other,}){
final _that = this;
switch (_that) {
case MessageNetworkFailure():
return network(_that);case MessageStorageFailure():
return storage(_that);case MessageOtherFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MessageNetworkFailure value)?  network,TResult? Function( MessageStorageFailure value)?  storage,TResult? Function( MessageOtherFailure value)?  other,}){
final _that = this;
switch (_that) {
case MessageNetworkFailure() when network != null:
return network(_that);case MessageStorageFailure() when storage != null:
return storage(_that);case MessageOtherFailure() when other != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? code,  String message,  StackTrace stackTrace)?  network,TResult Function( int? code,  String message,  StackTrace stackTrace)?  storage,TResult Function( int? code,  String message,  StackTrace stackTrace)?  other,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MessageNetworkFailure() when network != null:
return network(_that.code,_that.message,_that.stackTrace);case MessageStorageFailure() when storage != null:
return storage(_that.code,_that.message,_that.stackTrace);case MessageOtherFailure() when other != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? code,  String message,  StackTrace stackTrace)  network,required TResult Function( int? code,  String message,  StackTrace stackTrace)  storage,required TResult Function( int? code,  String message,  StackTrace stackTrace)  other,}) {final _that = this;
switch (_that) {
case MessageNetworkFailure():
return network(_that.code,_that.message,_that.stackTrace);case MessageStorageFailure():
return storage(_that.code,_that.message,_that.stackTrace);case MessageOtherFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? code,  String message,  StackTrace stackTrace)?  network,TResult? Function( int? code,  String message,  StackTrace stackTrace)?  storage,TResult? Function( int? code,  String message,  StackTrace stackTrace)?  other,}) {final _that = this;
switch (_that) {
case MessageNetworkFailure() when network != null:
return network(_that.code,_that.message,_that.stackTrace);case MessageStorageFailure() when storage != null:
return storage(_that.code,_that.message,_that.stackTrace);case MessageOtherFailure() when other != null:
return other(_that.code,_that.message,_that.stackTrace);case _:
  return null;

}
}

}

/// @nodoc


class MessageNetworkFailure implements MessageFailure {
  const MessageNetworkFailure({required this.code, required this.message, required this.stackTrace});
  

@override final  int? code;
@override final  String message;
@override final  StackTrace stackTrace;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageNetworkFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'MessageFailure.network(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




/// @nodoc


class MessageStorageFailure implements MessageFailure {
  const MessageStorageFailure({required this.code, required this.message, required this.stackTrace});
  

@override final  int? code;
@override final  String message;
@override final  StackTrace stackTrace;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageStorageFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'MessageFailure.storage(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




/// @nodoc


class MessageOtherFailure implements MessageFailure {
  const MessageOtherFailure({required this.code, required this.message, required this.stackTrace});
  

@override final  int? code;
@override final  String message;
@override final  StackTrace stackTrace;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageOtherFailure&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace));
}


@override
int get hashCode => Object.hash(runtimeType,code,message,stackTrace);

@override
String toString() {
  return 'MessageFailure.other(code: $code, message: $message, stackTrace: $stackTrace)';
}


}




// dart format on
