// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent()';
}


}




/// Adds pattern-matching-related methods to [ChatEvent].
extension ChatEventPatterns on ChatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _MessageSent value)?  messageSent,TResult Function( _MessageReceived value)?  messageReceived,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _MessageSent() when messageSent != null:
return messageSent(_that);case _MessageReceived() when messageReceived != null:
return messageReceived(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _MessageSent value)  messageSent,required TResult Function( _MessageReceived value)  messageReceived,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _MessageSent():
return messageSent(_that);case _MessageReceived():
return messageReceived(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _MessageSent value)?  messageSent,TResult? Function( _MessageReceived value)?  messageReceived,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _MessageSent() when messageSent != null:
return messageSent(_that);case _MessageReceived() when messageReceived != null:
return messageReceived(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String conversationId)?  started,TResult Function( String receiverId,  String content)?  messageSent,TResult Function( Message message)?  messageReceived,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.conversationId);case _MessageSent() when messageSent != null:
return messageSent(_that.receiverId,_that.content);case _MessageReceived() when messageReceived != null:
return messageReceived(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String conversationId)  started,required TResult Function( String receiverId,  String content)  messageSent,required TResult Function( Message message)  messageReceived,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.conversationId);case _MessageSent():
return messageSent(_that.receiverId,_that.content);case _MessageReceived():
return messageReceived(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String conversationId)?  started,TResult? Function( String receiverId,  String content)?  messageSent,TResult? Function( Message message)?  messageReceived,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.conversationId);case _MessageSent() when messageSent != null:
return messageSent(_that.receiverId,_that.content);case _MessageReceived() when messageReceived != null:
return messageReceived(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ChatEvent {
  const _Started({required this.conversationId});
  

 final  String conversationId;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId));
}


@override
int get hashCode => Object.hash(runtimeType,conversationId);

@override
String toString() {
  return 'ChatEvent.started(conversationId: $conversationId)';
}


}




/// @nodoc


class _MessageSent implements ChatEvent {
  const _MessageSent({required this.receiverId, required this.content});
  

 final  String receiverId;
 final  String content;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageSent&&(identical(other.receiverId, receiverId) || other.receiverId == receiverId)&&(identical(other.content, content) || other.content == content));
}


@override
int get hashCode => Object.hash(runtimeType,receiverId,content);

@override
String toString() {
  return 'ChatEvent.messageSent(receiverId: $receiverId, content: $content)';
}


}




/// @nodoc


class _MessageReceived implements ChatEvent {
  const _MessageReceived({required this.message});
  

 final  Message message;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageReceived&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ChatEvent.messageReceived(message: $message)';
}


}




/// @nodoc
mixin _$ChatState {

 ChatStatus get status; List<ConversationItem> get items; String? get conversationId; Profile? get peerProfile; String? get message;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.peerProfile, peerProfile) || other.peerProfile == peerProfile)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(items),conversationId,peerProfile,message);

@override
String toString() {
  return 'ChatState(status: $status, items: $items, conversationId: $conversationId, peerProfile: $peerProfile, message: $message)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 ChatStatus status, List<ConversationItem> items, String? conversationId, Profile? peerProfile, String? message
});




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? items = null,Object? conversationId = freezed,Object? peerProfile = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatStatus,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<ConversationItem>,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,peerProfile: freezed == peerProfile ? _self.peerProfile : peerProfile // ignore: cast_nullable_to_non_nullable
as Profile?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatState value)  $default,){
final _that = this;
switch (_that) {
case _ChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ChatStatus status,  List<ConversationItem> items,  String? conversationId,  Profile? peerProfile,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.status,_that.items,_that.conversationId,_that.peerProfile,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ChatStatus status,  List<ConversationItem> items,  String? conversationId,  Profile? peerProfile,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ChatState():
return $default(_that.status,_that.items,_that.conversationId,_that.peerProfile,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ChatStatus status,  List<ConversationItem> items,  String? conversationId,  Profile? peerProfile,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.status,_that.items,_that.conversationId,_that.peerProfile,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ChatState implements ChatState {
  const _ChatState({this.status = ChatStatus.initial, final  List<ConversationItem> items = const [], this.conversationId, this.peerProfile, this.message}): _items = items;
  

@override@JsonKey() final  ChatStatus status;
 final  List<ConversationItem> _items;
@override@JsonKey() List<ConversationItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? conversationId;
@override final  Profile? peerProfile;
@override final  String? message;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.conversationId, conversationId) || other.conversationId == conversationId)&&(identical(other.peerProfile, peerProfile) || other.peerProfile == peerProfile)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_items),conversationId,peerProfile,message);

@override
String toString() {
  return 'ChatState(status: $status, items: $items, conversationId: $conversationId, peerProfile: $peerProfile, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 ChatStatus status, List<ConversationItem> items, String? conversationId, Profile? peerProfile, String? message
});




}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? items = null,Object? conversationId = freezed,Object? peerProfile = freezed,Object? message = freezed,}) {
  return _then(_ChatState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChatStatus,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<ConversationItem>,conversationId: freezed == conversationId ? _self.conversationId : conversationId // ignore: cast_nullable_to_non_nullable
as String?,peerProfile: freezed == peerProfile ? _self.peerProfile : peerProfile // ignore: cast_nullable_to_non_nullable
as Profile?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
