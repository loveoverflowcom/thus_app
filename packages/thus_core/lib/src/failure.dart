import 'package:equatable/equatable.dart';

/// Base class for all failures in the domain layer.
class Failure extends Equatable {
  const Failure({required this.message, this.cause, this.stackTrace});

  final String message;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, cause, stackTrace];

  @override
  String toString() => 'Failure(message: $message, cause: $cause)';
}
