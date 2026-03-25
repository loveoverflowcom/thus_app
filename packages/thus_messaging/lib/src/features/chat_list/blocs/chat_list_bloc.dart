import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thus_contacts/thus_contacts.dart';

import 'package:thus_messaging/src/data/message_repository/message_repository.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_domain_event.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_failure.dart';
import 'package:thus_messaging/src/data/models/chat.dart';
import 'package:thus_messaging/src/data/models/chat_list_item.dart';

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
    @Default([]) List<ChatListItem> items,
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
  ChatListBloc(
    this._repository,
    this._contactRepository,
    this._profileCache,
  ) : super(const ChatListState()) {
    on<_Started>(_onLoad);
    on<_Refreshed>(_onLoad);

    _subscription = _repository.events.listen((event) {
      switch (event) {
        case MessageReceived():
          add(const ChatListEvent.refreshed());
      }
    });
  }

  final MessageRepository _repository;
  final ContactRepository _contactRepository;
  final ProfileCache _profileCache;
  late final StreamSubscription<MessageDomainEvent> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }

  Future<void> _onLoad(ChatListEvent event, Emitter<ChatListState> emit) async {
    if (event is _Started) {
      emit(state.copyWith(status: ChatListStatus.loading));
    }

    final result = await _repository.loadChats().run();
    await result.match(
      (failure) async => emit(state.copyWith(
        status: ChatListStatus.failure,
        message: _failureMessage(failure),
      )),
      (chats) async {
        final items = await _enrichChats(chats);
        emit(state.copyWith(status: ChatListStatus.success, items: items));
      },
    );
  }

  /// Resolves peer profile for each chat.
  /// The peer is the other participant — i.e. the conversationId itself
  /// (which equals the peer's userId in 1-on-1 chats).
  Future<List<ChatListItem>> _enrichChats(List<Chat> chats) async {
    // Each chat.id == peer userId in current 1-on-1 model
    final peerIds = chats.map((c) => c.id).toSet();
    final missingIds = _profileCache.missing(peerIds);

    if (missingIds.isNotEmpty) {
      final result =
          await _contactRepository.getProfilesByIds(missingIds).run();
      result.fold(
        (_) {},
        (profiles) {
          for (final entry in profiles.entries) {
            _profileCache.put(entry.key, entry.value);
          }
        },
      );
    }

    return chats
        .map((chat) => ChatListItem(
              chat: chat,
              peerProfile: _profileCache.getOrFallback(chat.id),
            ))
        .toList(growable: false);
  }

  String _failureMessage(MessageFailure failure) => switch (failure) {
        MessageNetworkFailure(:final message) => message,
        MessageStorageFailure(:final message) => message,
        MessageOtherFailure(:final message) => message,
      };
}
