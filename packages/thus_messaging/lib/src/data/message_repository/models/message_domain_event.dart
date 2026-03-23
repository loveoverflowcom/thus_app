import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_domain_event.freezed.dart';

@Freezed(copyWith: false)
sealed class MessageDomainEvent with _$MessageDomainEvent {
  const factory MessageDomainEvent.received({
    required String conversationId,
    required String messageId,
  }) = MessageReceived;
}
