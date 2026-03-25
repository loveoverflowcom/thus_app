import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:thus_contacts/thus_contacts.dart';

part 'user_search_bloc.freezed.dart';

// ─────────────────────────────
// Event
// ─────────────────────────────

@Freezed(copyWith: false)
sealed class UserSearchEvent with _$UserSearchEvent {
  const factory UserSearchEvent.queryChanged(String query) = _QueryChanged;
  const factory UserSearchEvent.retried() = _Retried;
  // Internal event fired after debounce delay
  const factory UserSearchEvent.search(String query) = _Search;
}

// ─────────────────────────────
// State
// ─────────────────────────────

@freezed
sealed class UserSearchState with _$UserSearchState {
  const factory UserSearchState({
    @Default('') String query,
    @Default(UserSearchStatus.idle) UserSearchStatus status,
    @Default([]) List<Profile> results,
    String? errorMessage,
  }) = _UserSearchState;
}

enum UserSearchStatus { idle, loading, success, failure }

// ─────────────────────────────
// Bloc
// ─────────────────────────────

final class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  UserSearchBloc(this._contactRepository) : super(const UserSearchState()) {
    on<_QueryChanged>(_onQueryChanged);
    on<_Retried>(_onRetried);
    on<_Search>(_onSearch);
  }

  final ContactRepository _contactRepository;
  Timer? _debounceTimer;

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }

  void _onQueryChanged(_QueryChanged event, Emitter<UserSearchState> emit) {
    final query = event.query.trim();
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      emit(const UserSearchState());
      return;
    }

    emit(state.copyWith(
      query: query,
      status: UserSearchStatus.loading,
      errorMessage: null,
    ));

    _debounceTimer = Timer(
      const Duration(milliseconds: 300),
      () => add(UserSearchEvent.search(query)),
    );
  }

  Future<void> _onRetried(
    _Retried event,
    Emitter<UserSearchState> emit,
  ) async {
    if (state.query.isEmpty) return;
    emit(state.copyWith(
      status: UserSearchStatus.loading,
      errorMessage: null,
    ));
    await _doSearch(state.query, emit);
  }

  Future<void> _onSearch(_Search event, Emitter<UserSearchState> emit) async {
    await _doSearch(event.query, emit);
  }

  Future<void> _doSearch(String query, Emitter<UserSearchState> emit) async {
    final result = await _contactRepository
        .searchProfiles(usernamePrefix: query)
        .run();
    result.match(
      (failure) => emit(state.copyWith(
        status: UserSearchStatus.failure,
        errorMessage: failure.toString(),
      )),
      (profiles) => emit(state.copyWith(
        status: UserSearchStatus.success,
        results: profiles,
      )),
    );
  }
}
