import 'package:thus_contacts/thus_contacts.dart';
import 'package:thus_messaging/src/data/models/chat.dart';

/// A [Chat] enriched with the resolved peer profile.
/// Used only as a view model — profile is NOT persisted.
final class ChatListItem {
  const ChatListItem({required this.chat, required this.peerProfile});

  final Chat chat;
  final Profile peerProfile;

  String get displayName =>
      peerProfile.displayName ?? peerProfile.username;

  String get avatarInitial =>
      displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';

  String? get avatarUrl => peerProfile.avatarUrl;
}
