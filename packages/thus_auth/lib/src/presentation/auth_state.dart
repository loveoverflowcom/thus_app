part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  const AuthState._({required this.status, this.session, this.errorMessage});

  const AuthState.initial() : this._(status: AuthStatus.initial);

  const AuthState.loading() : this._(status: AuthStatus.loading);

  const AuthState.authenticated(AuthSession session)
    : this._(status: AuthStatus.authenticated, session: session);

  const AuthState.unauthenticated()
    : this._(status: AuthStatus.unauthenticated);

  const AuthState.failure(String message)
    : this._(status: AuthStatus.failure, errorMessage: message);

  final AuthStatus status;
  final AuthSession? session;
  final String? errorMessage;

  @override
  List<Object?> get props => <Object?>[status, session, errorMessage];
}
