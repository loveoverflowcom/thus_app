import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thus_core/thus_core.dart';

import '../domain/entities/auth_credentials.dart';
import '../domain/entities/auth_session.dart';
import '../domain/usecases/load_session.dart';
import '../domain/usecases/login.dart';
import '../domain/usecases/logout.dart';
import '../domain/usecases/refresh_session.dart';
import '../domain/usecases/register_account.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required LoadSession loadSession,
    required Login login,
    required RegisterAccount registerAccount,
    required RefreshSession refreshSession,
    required Logout logout,
  }) : _loadSession = loadSession,
       _login = login,
       _registerAccount = registerAccount,
       _refreshSession = refreshSession,
       _logout = logout,
       super(const AuthState.initial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RefreshRequested>(_onRefreshRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  final LoadSession _loadSession;
  final Login _login;
  final RegisterAccount _registerAccount;
  final RefreshSession _refreshSession;
  final Logout _logout;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(const AuthState.loading());

    final AuthSession? session = await _loadSession(const NoParams());
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
      operation: () => _login(
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
      operation: () => _registerAccount(
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
      final AuthSession refreshed = await _refreshSession(const NoParams());
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
    await _logout(const NoParams());
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
