import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/auth_repository.dart';
import '../domain/entities/auth_credentials.dart';
import '../domain/entities/auth_session.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthState.initial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RefreshRequested>(_onRefreshRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final AuthRepository _authRepository;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final AuthSession? session = await _authRepository.loadSession();
    if (session == null) {
      emit(const AuthState.unauthenticated());
      return;
    }

    emit(AuthState.authenticated(session));
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    await _authenticate(
      emit: emit,
      operation: () => _authRepository.login(
        AuthCredentials(username: event.username, password: event.password),
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    await _authenticate(
      emit: emit,
      operation: () => _authRepository.register(
        AuthCredentials(username: event.username, password: event.password),
      ),
    );
  }

  Future<void> _onRefreshRequested(
    RefreshRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    try {
      final AuthSession refreshed = await _authRepository.refreshSession();
      emit(AuthState.authenticated(refreshed));
    } on Object catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(AuthState.failure(error.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _authRepository.logout();
    emit(const AuthState.unauthenticated());
  }

  Future<void> _authenticate({
    required Emitter<AuthState> emit,
    required Future<AuthSession> Function() operation,
  }) async {
    emit(const AuthState.loading());

    try {
      final AuthSession session = await operation();
      emit(AuthState.authenticated(session));
    } on Object catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(AuthState.failure(error.toString()));
    }
  }
}
