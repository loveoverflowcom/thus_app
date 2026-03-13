part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {
  const AppStarted();
}

class CreateIdentity extends AuthEvent {
  const CreateIdentity(this.displayName);

  final String displayName;

  @override
  List<Object?> get props => [displayName];
}
