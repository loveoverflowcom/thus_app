part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class LoadConversation extends ChatEvent {
  const LoadConversation(this.conversationId);

  final String conversationId;

  @override
  List<Object?> get props => <Object?>[conversationId];
}

class SendChatMessage extends ChatEvent {
  const SendChatMessage({
    required this.receiverId,
    required this.content,
    this.source = 'thus_mobile',
  });

  final String receiverId;
  final String content;
  final String source;

  @override
  List<Object?> get props => <Object?>[receiverId, content, source];
}

class ChatMessageReceived extends ChatEvent {
  const ChatMessageReceived(this.message);

  final Message message;

  @override
  List<Object?> get props => <Object?>[message];
}
