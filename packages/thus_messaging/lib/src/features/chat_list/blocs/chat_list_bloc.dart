import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:thus_messaging/src/data/message_repository/message_repository.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_domain_event.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_failure.dart';
import 'package:thus_messaging/src/data/models/chat.dart';

part 'chat_list_bloc.freezed.dart';

// ─────────────────────────────
// Event
// ─────────────────────────────

@Freezed(copyWith: false)
sealed class ChatListEvent with _$ChatListEvent {
  const factory ChatListEvent.started() = _Started;
  const factory ChatListEvent.refreshed() = _Refreshed;
}

// ─────────────────────────────
// State
// ─────────────────────────────

@freezed
sealed class ChatListState with _$ChatListState {
  const factory ChatListState({
    @Default(ChatListStatus.initial) ChatListStatus status,
    @Default([]) List<Chat> chats,
    String? message,
  }) = _ChatListState;
}

enum ChatListStatus {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

// ─────────────────────────────
// Bloc
// ─────────────────────────────

final class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc(this._repository) : super(const ChatListState()) {
    on<_Started>(_onStarted);
    on<_Refreshed>(_onRefreshed);

    _subscription = _repository.events.listen((event) {
      switch (event) {
        case MessageReceived():
          add(const ChatListEvent.refreshed());
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

  Future<void> _onStarted(_Started event, Emitter<ChatListState> emit) async {
    emit(state.copyWith(status: ChatListStatus.loading));
    final result = await _repository.loadChats().run();
    result.match(
      (failure) => emit(
        state.copyWith(
          status: ChatListStatus.failure,
          message: _failureMessage(failure),
        ),
      ),
      (chats) => emit(
        state.copyWith(status: ChatListStatus.success, chats: chats),
      ),
    );
  }

  Future<void> _onRefreshed(
    _Refreshed event,
    Emitter<ChatListState> emit,
  ) async {
    final result = await _repository.loadChats().run();
    result.match(
      (failure) => emit(
        state.copyWith(
          status: ChatListStatus.failure,
          message: _failureMessage(failure),
        ),
      ),
      (chats) => emit(
        state.copyWith(status: ChatListStatus.success, chats: chats),
      ),
    );
  }

  String _failureMessage(MessageFailure failure) => switch (failure) {
        MessageNetworkFailure(:final message) => message,
        MessageStorageFailure(:final message) => message,
        MessageOtherFailure(:final message) => message,
      };
}
