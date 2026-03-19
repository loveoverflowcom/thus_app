part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, ready, failure }

class ChatState extends Equatable {
  const ChatState({
    required this.status,
    required this.messages,
    this.conversationId,
    this.errorMessage,
  });

  const ChatState.initial()
    : this(status: ChatStatus.initial, messages: const <Message>[]);

  final ChatStatus status;
  final List<Message> messages;
  final String? conversationId;
  final String? errorMessage;

  ChatState copyWith({
    ChatStatus? status,
    List<Message>? messages,
    String? conversationId,
    String? errorMessage,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      conversationId: conversationId ?? this.conversationId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    messages,
    conversationId,
    errorMessage,
  ];
}
