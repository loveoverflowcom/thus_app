import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:thus_auth/src/data/auth_repository.dart';
import 'package:thus_auth/src/data/models/auth_failure.dart';
import 'package:thus_auth/src/data/models/auth_session.dart';

part 'auth_bloc.freezed.dart';

// ─────────────────────────────
// Event
// ─────────────────────────────

@Freezed(copyWith: false)
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.loginSubmitted({
    required String username,
    required String password,
  }) = _LoginSubmitted;
  const factory AuthEvent.registerSubmitted({
    required String username,
    required String password,
  }) = _RegisterSubmitted;
  const factory AuthEvent.refreshRequested() = _RefreshRequested;
  const factory AuthEvent.logoutRequested() = _LogoutRequested;
}

// ─────────────────────────────
// State
// ─────────────────────────────

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    AuthSession? session,
    String? message,
  }) = _AuthState;
}

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  failure;

  bool get isLoading => this == loading;
  bool get isAuthenticated => this == authenticated;
  bool get isUnauthenticated => this == unauthenticated;
  bool get isFailure => this == failure;
}

// ─────────────────────────────
// Bloc
// ─────────────────────────────

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthState()) {
    on<_Started>(_onStarted);
    on<_LoginSubmitted>(_onLoginSubmitted);
    on<_RegisterSubmitted>(_onRegisterSubmitted);
    on<_RefreshRequested>(_onRefreshRequested);
    on<_LogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _repository;

  Future<void> _onStarted(_Started event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _repository.loadSession().run();
    result.match(
      (failure) => emit(
        state.copyWith(
          status: AuthStatus.unauthenticated,
          message: _failureMessage(failure),
        ),
      ),
      (session) => session != null
          ? emit(state.copyWith(status: AuthStatus.authenticated, session: session))
          : emit(state.copyWith(status: AuthStatus.unauthenticated)),
    );
  }

  Future<void> _onLoginSubmitted(
    _LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _repository
        .login(username: event.username, password: event.password)
        .run();
    result.match(
      (failure) => emit(
        state.copyWith(status: AuthStatus.failure, message: _failureMessage(failure)),
      ),
      (session) =>
          emit(state.copyWith(status: AuthStatus.authenticated, session: session)),
    );
  }

  Future<void> _onRegisterSubmitted(
    _RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _repository
        .register(username: event.username, password: event.password)
        .run();
    result.match(
      (failure) => emit(
        state.copyWith(status: AuthStatus.failure, message: _failureMessage(failure)),
      ),
      (session) =>
          emit(state.copyWith(status: AuthStatus.authenticated, session: session)),
    );
  }

  Future<void> _onRefreshRequested(
    _RefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final result = await _repository.refreshSession().run();
    result.match(
      (failure) => emit(
        state.copyWith(status: AuthStatus.failure, message: _failureMessage(failure)),
      ),
      (session) =>
          emit(state.copyWith(status: AuthStatus.authenticated, session: session)),
    );
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.logout().run();
    emit(state.copyWith(status: AuthStatus.unauthenticated, session: null));
  }

  String _failureMessage(AuthFailure failure) => switch (failure) {
        AuthNetworkFailure(:final message) => message,
        AuthUnauthorizedFailure(:final message) => message,
        AuthStorageFailure(:final message) => message,
        AuthOtherFailure(:final message) => message,
      };
}
