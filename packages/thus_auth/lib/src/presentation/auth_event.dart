part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class AppStarted extends AuthEvent {
  const AppStarted();
}

class LoginSubmitted extends AuthEvent {
  const LoginSubmitted({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => <Object?>[username, password];
}

class RegisterSubmitted extends AuthEvent {
  const RegisterSubmitted({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => <Object?>[username, password];
}

class RefreshRequested extends AuthEvent {
  const RefreshRequested();
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}
