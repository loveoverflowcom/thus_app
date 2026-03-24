import 'package:equatable/equatable.dart';

import 'package:thus_contacts/src/data/models/profile.dart';

class Contact extends Equatable {
  const Contact({
    required this.contactId,
    required this.createdAt,
    this.profile,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        contactId: json['contact_id'] as String,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? '') ??
            DateTime.now().toUtc(),
        profile: json['profile'] != null
            ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
            : null,
      );

  final String contactId;
  final DateTime createdAt;
  final Profile? profile;

  Map<String, dynamic> toJson() => {
        'contact_id': contactId,
        'created_at': createdAt.toIso8601String(),
        if (profile != null) 'profile': profile!.toJson(),
      };

  @override
  List<Object?> get props => [contactId, createdAt, profile];
}
