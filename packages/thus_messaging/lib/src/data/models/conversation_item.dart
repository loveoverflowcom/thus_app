import 'package:thus_contacts/thus_contacts.dart';
import 'package:thus_messaging/src/data/models/message.dart';

/// A message enriched with the resolved sender profile.
/// Used only as a view model — profile is NOT persisted into Message.
final class ConversationItem {
  const ConversationItem({
    required this.message,
    required this.senderProfile,
  });

  final Message message;

  /// Resolved sender profile. Falls back to [ProfileCache.unknown] if
  /// the profile could not be fetched.
  final Profile senderProfile;

  String get senderDisplayName =>
      senderProfile.displayName ?? senderProfile.username;

  String get senderAvatarUrl => senderProfile.avatarUrl ?? '';
}
