import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  const Profile({
    required this.userId,
    required this.username,
    this.displayName,
    this.avatarUrl,
    this.bio,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        userId: json['user_id'] as String,
        username: json['username'] as String,
        displayName: json['display_name'] as String?,
        avatarUrl: json['avatar_url'] as String?,
        bio: json['bio'] as String?,
        updatedAt: json['updated_at'] != null
            ? DateTime.tryParse(json['updated_at'] as String)
            : null,
      );

  final String userId;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'username': username,
        if (displayName != null) 'display_name': displayName,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
        if (bio != null) 'bio': bio,
        if (updatedAt != null) 'updated_at': updatedAt!.toIso8601String(),
      };

  Profile copyWith({
    String? userId,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? bio,
    DateTime? updatedAt,
  }) =>
      Profile(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        displayName: displayName ?? this.displayName,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        bio: bio ?? this.bio,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props =>
      [userId, username, displayName, avatarUrl, bio, updatedAt];
}
