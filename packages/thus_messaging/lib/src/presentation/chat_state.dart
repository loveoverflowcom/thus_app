part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, ready, failure }

class ChatState extends Equatable {
  const ChatState({
    required this.status,
    required this.messages,
    this.conversationId,
    this.error,
  });

  const ChatState.initial()
      : status = ChatStatus.initial,
        messages = const [],
        conversationId = null,
        error = null;

  final ChatStatus status;
  final List<Message> messages;
  final String? conversationId;
  final String? error;

  ChatState copyWith({
    ChatStatus? status,
    List<Message>? messages,
    String? conversationId,
    String? error,
  }) =>
      ChatState(
        status: status ?? this.status,
        messages: messages ?? this.messages,
        conversationId: conversationId ?? this.conversationId,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [status, messages, conversationId, error];
}
