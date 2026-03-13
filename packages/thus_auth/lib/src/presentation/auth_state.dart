part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

class AuthState extends Equatable {
  const AuthState._({required this.status, this.identity, this.error});

  const AuthState.initial() : this._(status: AuthStatus.initial);
  const AuthState.loading() : this._(status: AuthStatus.loading);
  const AuthState.authenticated(UserIdentity identity)
      : this._(status: AuthStatus.authenticated, identity: identity);
  const AuthState.unauthenticated() : this._(status: AuthStatus.unauthenticated);
  const AuthState.failure(String error) : this._(status: AuthStatus.failure, error: error);

  final AuthStatus status;
  final UserIdentity? identity;
  final String? error;

  @override
  List<Object?> get props => [status, identity, error];
}
