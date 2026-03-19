// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  MessageStatus get status => throw _privateConstructorUsedError;
  String get conversationId => throw _privateConstructorUsedError;
  String get eventName => throw _privateConstructorUsedError;
  String? get source => throw _privateConstructorUsedError;
  bool get isIncoming => throw _privateConstructorUsedError;
  String? get remoteEventId => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String receiverId,
    DateTime timestamp,
    String content,
    MessageStatus status,
    String conversationId,
    String eventName,
    String? source,
    bool isIncoming,
    String? remoteEventId,
  });
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? timestamp = null,
    Object? content = null,
    Object? status = null,
    Object? conversationId = null,
    Object? eventName = null,
    Object? source = freezed,
    Object? isIncoming = null,
    Object? remoteEventId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverId: null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as MessageStatus,
            conversationId: null == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                      as String,
            eventName: null == eventName
                ? _value.eventName
                : eventName // ignore: cast_nullable_to_non_nullable
                      as String,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String?,
            isIncoming: null == isIncoming
                ? _value.isIncoming
                : isIncoming // ignore: cast_nullable_to_non_nullable
                      as bool,
            remoteEventId: freezed == remoteEventId
                ? _value.remoteEventId
                : remoteEventId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
    _$MessageImpl value,
    $Res Function(_$MessageImpl) then,
  ) = __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String receiverId,
    DateTime timestamp,
    String content,
    MessageStatus status,
    String conversationId,
    String eventName,
    String? source,
    bool isIncoming,
    String? remoteEventId,
  });
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
    _$MessageImpl _value,
    $Res Function(_$MessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? timestamp = null,
    Object? content = null,
    Object? status = null,
    Object? conversationId = null,
    Object? eventName = null,
    Object? source = freezed,
    Object? isIncoming = null,
    Object? remoteEventId = freezed,
  }) {
    return _then(
      _$MessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverId: null == receiverId
            ? _value.receiverId
            : receiverId // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as MessageStatus,
        conversationId: null == conversationId
            ? _value.conversationId
            : conversationId // ignore: cast_nullable_to_non_nullable
                  as String,
        eventName: null == eventName
            ? _value.eventName
            : eventName // ignore: cast_nullable_to_non_nullable
                  as String,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String?,
        isIncoming: null == isIncoming
            ? _value.isIncoming
            : isIncoming // ignore: cast_nullable_to_non_nullable
                  as bool,
        remoteEventId: freezed == remoteEventId
            ? _value.remoteEventId
            : remoteEventId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.timestamp,
    required this.content,
    required this.status,
    required this.conversationId,
    this.eventName = 'chat.message',
    this.source,
    this.isIncoming = false,
    this.remoteEventId,
  });

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String receiverId;
  @override
  final DateTime timestamp;
  @override
  final String content;
  @override
  final MessageStatus status;
  @override
  final String conversationId;
  @override
  @JsonKey()
  final String eventName;
  @override
  final String? source;
  @override
  @JsonKey()
  final bool isIncoming;
  @override
  final String? remoteEventId;

  @override
  String toString() {
    return 'Message(id: $id, senderId: $senderId, receiverId: $receiverId, timestamp: $timestamp, content: $content, status: $status, conversationId: $conversationId, eventName: $eventName, source: $source, isIncoming: $isIncoming, remoteEventId: $remoteEventId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId) &&
            (identical(other.eventName, eventName) ||
                other.eventName == eventName) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.isIncoming, isIncoming) ||
                other.isIncoming == isIncoming) &&
            (identical(other.remoteEventId, remoteEventId) ||
                other.remoteEventId == remoteEventId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    receiverId,
    timestamp,
    content,
    status,
    conversationId,
    eventName,
    source,
    isIncoming,
    remoteEventId,
  );

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(this);
  }
}

abstract class _Message implements Message {
  const factory _Message({
    required final String id,
    required final String senderId,
    required final String receiverId,
    required final DateTime timestamp,
    required final String content,
    required final MessageStatus status,
    required final String conversationId,
    final String eventName,
    final String? source,
    final bool isIncoming,
    final String? remoteEventId,
  }) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get receiverId;
  @override
  DateTime get timestamp;
  @override
  String get content;
  @override
  MessageStatus get status;
  @override
  String get conversationId;
  @override
  String get eventName;
  @override
  String? get source;
  @override
  bool get isIncoming;
  @override
  String? get remoteEventId;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
