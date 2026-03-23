import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:thus_messaging/src/data/message_repository/message_repository.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_domain_event.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_failure.dart';
import 'package:thus_messaging/src/data/models/message.dart';

part 'chat_bloc.freezed.dart';

// ─────────────────────────────
// Event
// ─────────────────────────────

@Freezed(copyWith: false)
sealed class ChatEvent with _$ChatEvent {
  const factory ChatEvent.started({required String conversationId}) = _Started;
  const factory ChatEvent.messageSent({
    required String receiverId,
    required String content,
  }) = _MessageSent;
  const factory ChatEvent.messageReceived({required Message message}) =
      _MessageReceived;
}

// ─────────────────────────────
// State
// ─────────────────────────────

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState({
    @Default(ChatStatus.initial) ChatStatus status,
    @Default([]) List<Message> messages,
    String? conversationId,
    String? message,
  }) = _ChatState;
}

enum ChatStatus {
  initial,
  loading,
  ready,
  failure;

  bool get isLoading => this == loading;
  bool get isReady => this == ready;
  bool get isFailure => this == failure;
}

// ─────────────────────────────
// Bloc
// ─────────────────────────────

final class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._repository) : super(const ChatState()) {
    on<_Started>(_onStarted);
    on<_MessageSent>(_onMessageSent);
    on<_MessageReceived>(_onMessageReceived);

    _subscription = _repository.events.listen((event) {
      switch (event) {
        case MessageReceived(:final conversationId):
          if (conversationId == state.conversationId) {
            // Reload history when a new message arrives for this conversation
            add(ChatEvent.started(conversationId: conversationId));
          }
        }
    });
  }

  final MessageRepository _repository;
  late final StreamSubscription<MessageDomainEvent> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  Future<void> _onStarted(_Started event, Emitter<ChatState> emit) async {
    emit(state.copyWith(
      status: ChatStatus.loading,
      conversationId: event.conversationId,
    ));
    final result =
        await _repository.loadHistory(event.conversationId).run();
    result.match(
      (failure) => emit(
        state.copyWith(
          status: ChatStatus.failure,
          message: _failureMessage(failure),
        ),
      ),
      (messages) => emit(
        state.copyWith(status: ChatStatus.ready, messages: messages),
      ),
    );
  }

  Future<void> _onMessageSent(
    _MessageSent event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _repository
        .send(receiverId: event.receiverId, content: event.content)
        .run();
    result.match(
      (failure) => emit(
        state.copyWith(
          status: ChatStatus.failure,
          message: _failureMessage(failure),
        ),
      ),
      (sent) => add(ChatEvent.messageReceived(message: sent)),
    );
  }

  void _onMessageReceived(
    _MessageReceived event,
    Emitter<ChatState> emit,
  ) {
    final existing = state.messages;
    final alreadyExists = existing.any((m) => m.id == event.message.id);

    final List<Message> updated;
    if (alreadyExists) {
      updated = existing
          .map((m) => m.id == event.message.id ? event.message : m)
          .toList(growable: false);
    } else {
      updated = [...existing, event.message]
        ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    }

    emit(state.copyWith(status: ChatStatus.ready, messages: updated));
  }

  String _failureMessage(MessageFailure failure) => switch (failure) {
        MessageNetworkFailure(:final message) => message,
        MessageStorageFailure(:final message) => message,
        MessageOtherFailure(:final message) => message,
      };
}
