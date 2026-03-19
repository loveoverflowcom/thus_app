import 'package:equatable/equatable.dart';

class AuthCredentials extends Equatable {
  const AuthCredentials({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object?> get props => <Object?>[username, password];
}
