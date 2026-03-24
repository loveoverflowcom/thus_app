import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thus_contacts/src/data/contact_repository.dart';
import 'package:thus_contacts/src/data/models/contact.dart';
import 'package:thus_contacts/src/data/models/contact_request.dart';
import 'package:thus_contacts/src/data/models/profile.dart';

// ─────────────────────────────
// Events
// ─────────────────────────────

sealed class ContactsEvent {
  const ContactsEvent();
}

final class ContactsStarted extends ContactsEvent {
  const ContactsStarted({required this.userId});
  final String userId;
}

final class ContactsRefreshed extends ContactsEvent {
  const ContactsRefreshed({required this.userId});
  final String userId;
}

final class ContactRemoved extends ContactsEvent {
  const ContactRemoved({required this.userId, required this.otherUserId});
  final String userId;
  final String otherUserId;
}

final class ContactRequestSent extends ContactsEvent {
  const ContactRequestSent({required this.fromUser, required this.toUser});
  final String fromUser;
  final String toUser;
}

final class ContactRequestAccepted extends ContactsEvent {
  const ContactRequestAccepted({
    required this.requestId,
    required this.userId,
  });
  final String requestId;
  final String userId;
}

final class ContactRequestRejected extends ContactsEvent {
  const ContactRequestRejected({required this.requestId});
  final String requestId;
}

final class ContactRequestCancelled extends ContactsEvent {
  const ContactRequestCancelled({required this.requestId});
  final String requestId;
}

final class ProfileSearched extends ContactsEvent {
  const ProfileSearched({this.usernamePrefix});
  final String? usernamePrefix;
}

// ─────────────────────────────
// State
// ─────────────────────────────

enum ContactsStatus { initial, loading, success, failure }

final class ContactsState {
  const ContactsState({
    this.status = ContactsStatus.initial,
    this.contacts = const [],
    this.incomingRequests = const [],
    this.outgoingRequests = const [],
    this.searchResults = const [],
    this.message,
  });

  final ContactsStatus status;
  final List<Contact> contacts;
  final List<ContactRequest> incomingRequests;
  final List<ContactRequest> outgoingRequests;
  final List<Profile> searchResults;
  final String? message;

  bool get isLoading => status == ContactsStatus.loading;
  bool get isSuccess => status == ContactsStatus.success;
  bool get isFailure => status == ContactsStatus.failure;

  ContactsState copyWith({
    ContactsStatus? status,
    List<Contact>? contacts,
    List<ContactRequest>? incomingRequests,
    List<ContactRequest>? outgoingRequests,
    List<Profile>? searchResults,
    String? message,
  }) =>
      ContactsState(
        status: status ?? this.status,
        contacts: contacts ?? this.contacts,
        incomingRequests: incomingRequests ?? this.incomingRequests,
        outgoingRequests: outgoingRequests ?? this.outgoingRequests,
        searchResults: searchResults ?? this.searchResults,
        message: message ?? this.message,
      );
}

// ─────────────────────────────
// Bloc
// ─────────────────────────────

final class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc(this._repository) : super(const ContactsState()) {
    on<ContactsStarted>(_onLoad);
    on<ContactsRefreshed>(_onLoad);
    on<ContactRemoved>(_onContactRemoved);
    on<ContactRequestSent>(_onRequestSent);
    on<ContactRequestAccepted>(_onRequestAccepted);
    on<ContactRequestRejected>(_onRequestRejected);
    on<ContactRequestCancelled>(_onRequestCancelled);
    on<ProfileSearched>(_onProfileSearched);
  }

  final ContactRepository _repository;

  Future<void> _onLoad(ContactsEvent event, Emitter<ContactsState> emit) async {
    final userId = switch (event) {
      ContactsStarted(:final userId) => userId,
      ContactsRefreshed(:final userId) => userId,
      _ => null,
    };
    if (userId == null) return;

    emit(state.copyWith(status: ContactsStatus.loading));

    final contacts =
        (await _repository.listMyContacts(userId).run()).getOrElse((_) => []);
    final incoming = (await _repository.listIncomingRequests(userId).run())
        .getOrElse((_) => []);
    final outgoing = (await _repository.listOutgoingRequests(userId).run())
        .getOrElse((_) => []);

    emit(state.copyWith(
      status: ContactsStatus.success,
      contacts: contacts,
      incomingRequests: incoming,
      outgoingRequests: outgoing,
    ));
  }

  Future<void> _onContactRemoved(
    ContactRemoved event,
    Emitter<ContactsState> emit,
  ) async {
    final result = await _repository.removeContact(event.otherUserId).run();
    result.match(
      (f) => emit(state.copyWith(
        status: ContactsStatus.failure,
        message: f.message,
      )),
      (_) => add(ContactsRefreshed(userId: event.userId)),
    );
  }

  Future<void> _onRequestSent(
    ContactRequestSent event,
    Emitter<ContactsState> emit,
  ) async {
    final result = await _repository
        .sendContactRequest(fromUser: event.fromUser, toUser: event.toUser)
        .run();
    result.match(
      (f) => emit(state.copyWith(
        status: ContactsStatus.failure,
        message: f.message,
      )),
      (req) => emit(state.copyWith(
        outgoingRequests: [...state.outgoingRequests, req],
      )),
    );
  }

  Future<void> _onRequestAccepted(
    ContactRequestAccepted event,
    Emitter<ContactsState> emit,
  ) async {
    final result =
        await _repository.acceptContactRequest(event.requestId).run();
    result.match(
      (f) => emit(state.copyWith(
        status: ContactsStatus.failure,
        message: f.message,
      )),
      (_) {
        emit(state.copyWith(
          incomingRequests: state.incomingRequests
              .where((r) => r.id != event.requestId)
              .toList(),
        ));
        add(ContactsRefreshed(userId: event.userId));
      },
    );
  }

  Future<void> _onRequestRejected(
    ContactRequestRejected event,
    Emitter<ContactsState> emit,
  ) async {
    final result =
        await _repository.rejectContactRequest(event.requestId).run();
    result.match(
      (f) => emit(state.copyWith(
        status: ContactsStatus.failure,
        message: f.message,
      )),
      (_) => emit(state.copyWith(
        incomingRequests: state.incomingRequests
            .where((r) => r.id != event.requestId)
            .toList(),
      )),
    );
  }

  Future<void> _onRequestCancelled(
    ContactRequestCancelled event,
    Emitter<ContactsState> emit,
  ) async {
    final result =
        await _repository.cancelContactRequest(event.requestId).run();
    result.match(
      (f) => emit(state.copyWith(
        status: ContactsStatus.failure,
        message: f.message,
      )),
      (_) => emit(state.copyWith(
        outgoingRequests: state.outgoingRequests
            .where((r) => r.id != event.requestId)
            .toList(),
      )),
    );
  }

  Future<void> _onProfileSearched(
    ProfileSearched event,
    Emitter<ContactsState> emit,
  ) async {
    final result = await _repository
        .searchProfiles(usernamePrefix: event.usernamePrefix)
        .run();
    result.match(
      (f) => emit(state.copyWith(
        status: ContactsStatus.failure,
        message: f.message,
      )),
      (profiles) => emit(state.copyWith(searchResults: profiles)),
    );
  }
}
