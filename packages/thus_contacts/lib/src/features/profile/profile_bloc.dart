import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:thus_contacts/src/data/contact_repository.dart';
import 'package:thus_contacts/src/data/models/contact_failure.dart';
import 'package:thus_contacts/src/data/models/profile.dart';

// ─────────────────────────────
// Events
// ─────────────────────────────

sealed class ProfileEvent {
  const ProfileEvent();
}

final class ProfileStarted extends ProfileEvent {
  const ProfileStarted({required this.userId});
  final String userId;
}

final class ProfileUpdated extends ProfileEvent {
  const ProfileUpdated({
    required this.userId,
    this.displayName,
    this.avatarUrl,
    this.bio,
  });
  final String userId;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
}

// ─────────────────────────────
// State
// ─────────────────────────────

enum ProfileStatus { initial, loading, success, failure }

final class ProfileState {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile,
    this.message,
  });

  final ProfileStatus status;
  final Profile? profile;
  final String? message;

  bool get isLoading => status == ProfileStatus.loading;
  bool get isSuccess => status == ProfileStatus.success;
  bool get isFailure => status == ProfileStatus.failure;

  ProfileState copyWith({
    ProfileStatus? status,
    Profile? profile,
    String? message,
  }) =>
      ProfileState(
        status: status ?? this.status,
        profile: profile ?? this.profile,
        message: message ?? this.message,
      );
}

// ─────────────────────────────
// Bloc
// ─────────────────────────────

final class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._repository) : super(const ProfileState()) {
    on<ProfileStarted>(_onStarted);
    on<ProfileUpdated>(_onUpdated);
  }

  final ContactRepository _repository;

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _repository.getMyProfile(event.userId).run();
    result.match(
      (f) => emit(state.copyWith(
        status: ProfileStatus.failure,
        message: _msg(f),
      )),
      (profile) => emit(state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      )),
    );
  }

  Future<void> _onUpdated(
    ProfileUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    final result = await _repository
        .updateMyProfile(
          userId: event.userId,
          displayName: event.displayName,
          avatarUrl: event.avatarUrl,
          bio: event.bio,
        )
        .run();
    result.match(
      (f) => emit(state.copyWith(
        status: ProfileStatus.failure,
        message: _msg(f),
      )),
      (profile) => emit(state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      )),
    );
  }

  String _msg(ContactFailure f) => f.message;
}
