// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) started,
    required TResult Function(String receiverId, String content) messageSent,
    required TResult Function(Message message) messageReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? started,
    TResult? Function(String receiverId, String content)? messageSent,
    TResult? Function(Message message)? messageReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? started,
    TResult Function(String receiverId, String content)? messageSent,
    TResult Function(Message message)? messageReceived,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_MessageReceived value) messageReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_MessageReceived value)? messageReceived,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_MessageReceived value)? messageReceived,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl({required this.conversationId});

  @override
  final String conversationId;

  @override
  String toString() {
    return 'ChatEvent.started(conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartedImpl &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, conversationId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) started,
    required TResult Function(String receiverId, String content) messageSent,
    required TResult Function(Message message) messageReceived,
  }) {
    return started(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? started,
    TResult? Function(String receiverId, String content)? messageSent,
    TResult? Function(Message message)? messageReceived,
  }) {
    return started?.call(conversationId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? started,
    TResult Function(String receiverId, String content)? messageSent,
    TResult Function(Message message)? messageReceived,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(conversationId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_MessageReceived value) messageReceived,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_MessageReceived value)? messageReceived,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_MessageReceived value)? messageReceived,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements ChatEvent {
  const factory _Started({required final String conversationId}) =
      _$StartedImpl;

  String get conversationId;
}

/// @nodoc

class _$MessageSentImpl implements _MessageSent {
  const _$MessageSentImpl({required this.receiverId, required this.content});

  @override
  final String receiverId;
  @override
  final String content;

  @override
  String toString() {
    return 'ChatEvent.messageSent(receiverId: $receiverId, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageSentImpl &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, receiverId, content);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) started,
    required TResult Function(String receiverId, String content) messageSent,
    required TResult Function(Message message) messageReceived,
  }) {
    return messageSent(receiverId, content);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? started,
    TResult? Function(String receiverId, String content)? messageSent,
    TResult? Function(Message message)? messageReceived,
  }) {
    return messageSent?.call(receiverId, content);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? started,
    TResult Function(String receiverId, String content)? messageSent,
    TResult Function(Message message)? messageReceived,
    required TResult orElse(),
  }) {
    if (messageSent != null) {
      return messageSent(receiverId, content);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_MessageReceived value) messageReceived,
  }) {
    return messageSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_MessageReceived value)? messageReceived,
  }) {
    return messageSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_MessageReceived value)? messageReceived,
    required TResult orElse(),
  }) {
    if (messageSent != null) {
      return messageSent(this);
    }
    return orElse();
  }
}

abstract class _MessageSent implements ChatEvent {
  const factory _MessageSent({
    required final String receiverId,
    required final String content,
  }) = _$MessageSentImpl;

  String get receiverId;
  String get content;
}

/// @nodoc

class _$MessageReceivedImpl implements _MessageReceived {
  const _$MessageReceivedImpl({required this.message});

  @override
  final Message message;

  @override
  String toString() {
    return 'ChatEvent.messageReceived(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageReceivedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String conversationId) started,
    required TResult Function(String receiverId, String content) messageSent,
    required TResult Function(Message message) messageReceived,
  }) {
    return messageReceived(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String conversationId)? started,
    TResult? Function(String receiverId, String content)? messageSent,
    TResult? Function(Message message)? messageReceived,
  }) {
    return messageReceived?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String conversationId)? started,
    TResult Function(String receiverId, String content)? messageSent,
    TResult Function(Message message)? messageReceived,
    required TResult orElse(),
  }) {
    if (messageReceived != null) {
      return messageReceived(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_MessageSent value) messageSent,
    required TResult Function(_MessageReceived value) messageReceived,
  }) {
    return messageReceived(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_MessageSent value)? messageSent,
    TResult? Function(_MessageReceived value)? messageReceived,
  }) {
    return messageReceived?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_MessageSent value)? messageSent,
    TResult Function(_MessageReceived value)? messageReceived,
    required TResult orElse(),
  }) {
    if (messageReceived != null) {
      return messageReceived(this);
    }
    return orElse();
  }
}

abstract class _MessageReceived implements ChatEvent {
  const factory _MessageReceived({required final Message message}) =
      _$MessageReceivedImpl;

  Message get message;
}

/// @nodoc
mixin _$ChatState {
  ChatStatus get status => throw _privateConstructorUsedError;
  List<Message> get messages => throw _privateConstructorUsedError;
  String? get conversationId => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatStateCopyWith<ChatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res, ChatState>;
  @useResult
  $Res call({
    ChatStatus status,
    List<Message> messages,
    String? conversationId,
    String? message,
  });
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res, $Val extends ChatState>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? messages = null,
    Object? conversationId = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ChatStatus,
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<Message>,
            conversationId: freezed == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatStateImplCopyWith<$Res>
    implements $ChatStateCopyWith<$Res> {
  factory _$$ChatStateImplCopyWith(
    _$ChatStateImpl value,
    $Res Function(_$ChatStateImpl) then,
  ) = __$$ChatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ChatStatus status,
    List<Message> messages,
    String? conversationId,
    String? message,
  });
}

/// @nodoc
class __$$ChatStateImplCopyWithImpl<$Res>
    extends _$ChatStateCopyWithImpl<$Res, _$ChatStateImpl>
    implements _$$ChatStateImplCopyWith<$Res> {
  __$$ChatStateImplCopyWithImpl(
    _$ChatStateImpl _value,
    $Res Function(_$ChatStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? messages = null,
    Object? conversationId = freezed,
    Object? message = freezed,
  }) {
    return _then(
      _$ChatStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ChatStatus,
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
        conversationId: freezed == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ChatStateImpl implements _ChatState {
  const _$ChatStateImpl({
    this.status = ChatStatus.initial,
    final List<Message> messages = const [],
    this.conversationId,
    this.message,
  }) : _messages = messages;

  @override
  @JsonKey()
  final ChatStatus status;
  final List<Message> _messages;
  @override
  @JsonKey()
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  final String? conversationId;
  @override
  final String? message;

  @override
  String toString() {
    return 'ChatState(status: $status, messages: $messages, conversationId: $conversationId, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_messages),
    conversationId,
    message,
  );

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      __$$ChatStateImplCopyWithImpl<_$ChatStateImpl>(this, _$identity);
}

abstract class _ChatState implements ChatState {
  const factory _ChatState({
    final ChatStatus status,
    final List<Message> messages,
    final String? conversationId,
    final String? message,
  }) = _$ChatStateImpl;

  @override
  ChatStatus get status;
  @override
  List<Message> get messages;
  @override
  String? get conversationId;
  @override
  String? get message;

  /// Create a copy of ChatState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatStateImplCopyWith<_$ChatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
