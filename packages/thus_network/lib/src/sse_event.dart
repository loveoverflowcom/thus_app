import 'package:equatable/equatable.dart';

class SseEvent extends Equatable {
  const SseEvent({required this.event, required this.data, this.id});

  final String event;
  final String data;
  final String? id;

  @override
  List<Object?> get props => <Object?>[event, data, id];
}
