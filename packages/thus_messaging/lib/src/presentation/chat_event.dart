part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadConversation extends ChatEvent {
  const LoadConversation(this.conversationId);
  final String conversationId;

  @override
  List<Object?> get props => [conversationId];
}

class SendChatMessage extends ChatEvent {
  const SendChatMessage({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.status = MessageStatus.sending,
  });

  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final MessageStatus status;

  @override
  List<Object?> get props => [id, senderId, receiverId, content, status];
}

class _IncomingMessage extends ChatEvent {
  const _IncomingMessage(this.message);
  final Message message;

  @override
  List<Object?> get props => [message];
}
