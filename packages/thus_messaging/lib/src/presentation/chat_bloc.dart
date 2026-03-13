import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../domain/entities/message.dart';
import '../domain/usecases/load_chat_history.dart';
import '../domain/usecases/send_message.dart';
import '../domain/usecases/subscribe_chat_stream.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._loadChatHistory, this._sendMessage, this._subscribe)
      : super(const ChatState.initial()) {
    on<LoadConversation>(_onLoadConversation);
    on<SendChatMessage>(_onSendMessage);
    on<_IncomingMessage>(_onIncomingMessage);
  }

  final LoadChatHistory _loadChatHistory;
  final SendMessage _sendMessage;
  final SubscribeChatStream _subscribe;

  Future<void> _onLoadConversation(LoadConversation event, Emitter<ChatState> emit) async {
    emit(state.copyWith(status: ChatStatus.loading, conversationId: event.conversationId));
    final history = await _loadChatHistory.call(event.conversationId);
    emit(state.copyWith(status: ChatStatus.ready, messages: history));

    final stream = await _subscribe.call(event.conversationId);
    await emit.forEach<Message>(stream, onData: (message) {
      return state.copyWith(messages: [...state.messages, message]);
    });
  }

  Future<void> _onSendMessage(SendChatMessage event, Emitter<ChatState> emit) async {
    final message = Message(
      id: event.id,
      senderId: event.senderId,
      receiverId: event.receiverId,
      timestamp: DateTime.now().toUtc(),
      content: event.content,
      status: event.status,
      conversationId: state.conversationId,
    );
    final persisted = await _sendMessage.call(message);
    emit(state.copyWith(messages: [...state.messages, persisted]));
  }

  void _onIncomingMessage(_IncomingMessage event, Emitter<ChatState> emit) {
    emit(state.copyWith(messages: [...state.messages, event.message]));
  }
}
