// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Message {

 String get id; String get senderId; String get receiverId; DateTime get timestamp; String get content; MessageStatus get status; String get conversationId; String get eventName; String? get source; bool get isIncoming; String? get remoteEventId;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.source, source) || other.source == source)&&(identical(other.isIncoming, isIncoming) || other.isIncoming == isIncoming)&&(identical(other.remoteEventId, remoteEventId) || other.remoteEventId == remoteEventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,receiverId,timestamp,content,status,conversationId,eventName,source,isIncoming,remoteEventId);

@override
String toString() {
  return 'Message(id: $id, senderId: $senderId, receiverId: $receiverId, timestamp: $timestamp, content: $content, status: $status, conversationId: $conversationId, eventName: $eventName, source: $source, isIncoming: $isIncoming, remoteEventId: $remoteEventId)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String receiverId, DateTime timestamp, String content, MessageStatus status, String conversationId, String eventName, String? source, bool isIncoming, String? remoteEventId
});




}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? receiverId = null,Object? timestamp = null,Object? content = null,Object? status = null,Object? conversationId = null,Object? eventName = null,Object? source = freezed,Object? isIncoming = null,Object? remoteEventId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,eventName: null == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,isIncoming: null == isIncoming ? _self.isIncoming : isIncoming // ignore: cast_nullable_to_non_nullable
as bool,remoteEventId: freezed == remoteEventId ? _self.remoteEventId : remoteEventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Message value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Message value)  $default,){
final _that = this;
switch (_that) {
case _Message():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Message value)?  $default,){
final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String receiverId,  DateTime timestamp,  String content,  MessageStatus status,  String conversationId,  String eventName,  String? source,  bool isIncoming,  String? remoteEventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.senderId,_that.receiverId,_that.timestamp,_that.content,_that.status,_that.conversationId,_that.eventName,_that.source,_that.isIncoming,_that.remoteEventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String receiverId,  DateTime timestamp,  String content,  MessageStatus status,  String conversationId,  String eventName,  String? source,  bool isIncoming,  String? remoteEventId)  $default,) {final _that = this;
switch (_that) {
case _Message():
return $default(_that.id,_that.senderId,_that.receiverId,_that.timestamp,_that.content,_that.status,_that.conversationId,_that.eventName,_that.source,_that.isIncoming,_that.remoteEventId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String receiverId,  DateTime timestamp,  String content,  MessageStatus status,  String conversationId,  String eventName,  String? source,  bool isIncoming,  String? remoteEventId)?  $default,) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.senderId,_that.receiverId,_that.timestamp,_that.content,_that.status,_that.conversationId,_that.eventName,_that.source,_that.isIncoming,_that.remoteEventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Message implements Message {
  const _Message({required this.id, required this.senderId, required this.receiverId, required this.timestamp, required this.content, required this.status, required this.conversationId, this.eventName = 'chat.message', this.source, this.isIncoming = false, this.remoteEventId});
  factory _Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

@override final  String id;
@override final  String senderId;
@override final  String receiverId;
@override final  DateTime timestamp;
@override final  String content;
@override final  MessageStatus status;
@override final  String conversationId;
@override@JsonKey() final  String eventName;
@override final  String? source;
@override@JsonKey() final  bool isIncoming;
@override final  String? remoteEventId;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageCopyWith<_Message> get copyWith => __$MessageCopyWithImpl<_Message>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Message&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.eventName, eventName) || other.eventName == eventName)&&(identical(other.source, source) || other.source == source)&&(identical(other.isIncoming, isIncoming) || other.isIncoming == isIncoming)&&(identical(other.remoteEventId, remoteEventId) || other.remoteEventId == remoteEventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,receiverId,timestamp,content,status,conversationId,eventName,source,isIncoming,remoteEventId);

@override
String toString() {
  return 'Message(id: $id, senderId: $senderId, receiverId: $receiverId, timestamp: $timestamp, content: $content, status: $status, conversationId: $conversationId, eventName: $eventName, source: $source, isIncoming: $isIncoming, remoteEventId: $remoteEventId)';
}


}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) = __$MessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String receiverId, DateTime timestamp, String content, MessageStatus status, String conversationId, String eventName, String? source, bool isIncoming, String? remoteEventId
});




}
/// @nodoc
class __$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? receiverId = null,Object? timestamp = null,Object? content = null,Object? status = null,Object? conversationId = null,Object? eventName = null,Object? source = freezed,Object? isIncoming = null,Object? remoteEventId = freezed,}) {
  return _then(_Message(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,receiverId: null == receiverId ? _self.receiverId : receiverId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MessageStatus,conversationId: null == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String,eventName: null == eventName ? _self.eventName : eventName // ignore: cast_nullable_to_non_nullable
as String,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,isIncoming: null == isIncoming ? _self.isIncoming : isIncoming // ignore: cast_nullable_to_non_nullable
as bool,remoteEventId: freezed == remoteEventId ? _self.remoteEventId : remoteEventId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
