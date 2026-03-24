import 'package:equatable/equatable.dart';

enum ContactRequestStatus { pending, accepted, rejected }

class ContactRequest extends Equatable {
  const ContactRequest({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.status,
    required this.createdAt,
  });

  factory ContactRequest.fromJson(Map<String, dynamic> json) => ContactRequest(
        id: json['id'] as String,
        fromUser: (json['from_user'] as String?) ?? '',
        toUser: (json['to_user'] as String?) ?? '',
        status: _parseStatus(json['status'] as String?),
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
            DateTime.now().toUtc(),
      );

  static ContactRequestStatus _parseStatus(String? raw) => switch (raw) {
        'accepted' => ContactRequestStatus.accepted,
        'rejected' => ContactRequestStatus.rejected,
        _ => ContactRequestStatus.pending,
      };

  final String id;
  final String fromUser;
  final String toUser;
  final ContactRequestStatus status;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'from_user': fromUser,
        'to_user': toUser,
        'status': status.name,
        'created_at': createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [id, fromUser, toUser, status, createdAt];
}
