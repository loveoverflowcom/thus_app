import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thus_contacts/thus_contacts.dart';

import 'package:thus_messaging/src/data/message_repository/message_repository.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_domain_event.dart';
import 'package:thus_messaging/src/data/message_repository/models/message_failure.dart';
import 'package:thus_messaging/src/data/models/conversation_item.dart';
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
    @Default([]) List<ConversationItem> items,
    String? conversationId,
    Profile? peerProfile,
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
  ChatBloc(
    this._repository,
    this._contactRepository,
    this._profileCache,
  ) : super(const ChatState()) {
    on<_Started>(_onStarted);
    on<_MessageSent>(_onMessageSent);
    on<_MessageReceived>(_onMessageReceived);

    _subscription = _repository.events.listen((event) {
      switch (event) {
        case MessageReceived(:final conversationId):
          if (conversationId == state.conversationId) {
            add(ChatEvent.started(conversationId: conversationId));
          }
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

  Future<void> _onStarted(_Started event, Emitter<ChatState> emit) async {
    emit(state.copyWith(
      status: ChatStatus.loading,
      conversationId: event.conversationId,
    ));

    final result = await _repository.loadHistory(event.conversationId).run();
    await result.match(
      (failure) async => emit(state.copyWith(
        status: ChatStatus.failure,
        message: _failureMessage(failure),
      )),
      (messages) async {
        final items = await _enrichMessages(messages);
        // Peer in 1-on-1 chat = conversationId = peer's userId.
        // If cache still empty (no messages yet), fetch peer directly.
        final peerProfile = await _resolveOne(event.conversationId);
        emit(state.copyWith(
          status: ChatStatus.ready,
          items: items,
          peerProfile: peerProfile,
        ));
      },
    );
  }

  Future<void> _onMessageSent(
    _MessageSent event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _repository
        .send(
          receiverId: event.receiverId,
          content: event.content,
          eventType: 'chat.message',
        )
        .run();
    result.match(
      (failure) => emit(state.copyWith(
        status: ChatStatus.failure,
        message: _failureMessage(failure),
      )),
      (sent) => add(ChatEvent.messageReceived(message: sent)),
    );
  }

  Future<void> _onMessageReceived(
    _MessageReceived event,
    Emitter<ChatState> emit,
  ) async {
    final existing = state.items;
    final alreadyExists = existing.any((i) => i.message.id == event.message.id);

    final List<ConversationItem> updated;
    if (alreadyExists) {
      // Re-resolve profile for updated message
      final profile = await _resolveOne(event.message.senderId);
      updated = existing
          .map((i) => i.message.id == event.message.id
              ? ConversationItem(message: event.message, senderProfile: profile)
              : i)
          .toList(growable: false);
    } else {
      final profile = await _resolveOne(event.message.senderId);
      final newItem =
          ConversationItem(message: event.message, senderProfile: profile);
      updated = [...existing, newItem]
        ..sort((a, b) =>
            a.message.timestamp.compareTo(b.message.timestamp));
    }

    emit(state.copyWith(status: ChatStatus.ready, items: updated));
  }

  // ── Profile resolution ────────────────────────────────────────────────────

  /// Enriches a list of messages with sender profiles.
  /// Deduplicates userIds, fetches missing ones in a single batch call.
  Future<List<ConversationItem>> _enrichMessages(
    List<Message> messages,
  ) async {
    final missingIds = _profileCache.missing(
      messages.map((m) => m.senderId),
    );

    if (missingIds.isNotEmpty) {
      final result =
          await _contactRepository.getProfilesByIds(missingIds).run();
      result.fold(
        (_) {}, // silently ignore — fallback used below
        (profiles) {
          for (final entry in profiles.entries) {
            _profileCache.put(entry.key, entry.value);
          }
        },
      );
    }

    return messages
        .map((m) => ConversationItem(
              message: m,
              senderProfile: _profileCache.getOrFallback(m.senderId),
            ))
        .toList(growable: false);
  }

  /// Resolves a single sender, using cache first.
  Future<Profile> _resolveOne(String userId) async {
    if (_profileCache.has(userId)) {
      return _profileCache.getOrFallback(userId);
    }
    final result =
        await _contactRepository.getProfileById(userId).run();
    return result.fold(
      (_) => ProfileCache.unknown,
      (profile) {
        _profileCache.put(userId, profile);
        return profile;
      },
    );
  }

  String _failureMessage(MessageFailure failure) => switch (failure) {
        MessageNetworkFailure(:final message) => message,
        MessageStorageFailure(:final message) => message,
        MessageOtherFailure(:final message) => message,
      };
}
