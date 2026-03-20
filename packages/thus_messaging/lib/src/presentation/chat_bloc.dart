import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/message_repository.dart';
import '../domain/entities/message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._messageRepository) : super(const ChatState.initial()) {
    on<LoadConversation>(_onLoadConversation);
    on<SendChatMessage>(_onSendMessage);
    on<ChatMessageReceived>(_onMessageReceived);
  }

  final MessageRepository _messageRepository;

  StreamSubscription<Message>? _subscription;

  Future<void> _onLoadConversation(
    LoadConversation event,
    Emitter<ChatState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ChatStatus.loading,
        conversationId: event.conversationId,
        errorMessage: null,
      ),
    );

    try {
      final List<Message> history = await _messageRepository.loadHistory(
        event.conversationId,
      );
      emit(state.copyWith(status: ChatStatus.ready, messages: history));

      await _subscription?.cancel();
      final Stream<Message> stream = _messageRepository.subscribe(
        event.conversationId,
      );
      _subscription = stream.listen(
        (Message message) => add(ChatMessageReceived(message)),
        onError: addError,
      );
    } on Object catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: ChatStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onSendMessage(
    SendChatMessage event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final Message persisted = await _messageRepository.send(
        toUserId: event.receiverId,
        content: event.content,
        source: event.source,
      );

      add(ChatMessageReceived(persisted));
    } on Object catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(
        state.copyWith(
          status: ChatStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _onMessageReceived(ChatMessageReceived event, Emitter<ChatState> emit) {
    final bool alreadyExists = state.messages.any(
      (Message message) => message.id == event.message.id,
    );
    if (alreadyExists) {
      final List<Message> updated = state.messages
          .map(
            (Message message) =>
                message.id == event.message.id ? event.message : message,
          )
          .toList(growable: false);
      emit(state.copyWith(messages: updated));
      return;
    }

    final List<Message> updatedMessages =
        <Message>[...state.messages, event.message]..sort(
          (Message left, Message right) =>
              left.timestamp.compareTo(right.timestamp),
        );

    emit(state.copyWith(status: ChatStatus.ready, messages: updatedMessages));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
