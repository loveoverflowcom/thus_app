import 'package:fpdart/fpdart.dart';

import 'package:thus_contacts/src/data/models/contact.dart';
import 'package:thus_contacts/src/data/models/contact_failure.dart';
import 'package:thus_contacts/src/data/models/contact_request.dart';
import 'package:thus_contacts/src/data/models/profile.dart';

abstract class ContactRepository {
  // ── Profiles ──────────────────────────────────────────────────────────────

  TaskEither<ContactFailure, Profile> getMyProfile(String userId);

  TaskEither<ContactFailure, Profile> getProfileByUsername(String username);

  TaskEither<ContactFailure, Profile> getProfileById(String userId);

  /// Batch-fetch profiles for a set of userIds.
  /// Deduplicates internally. Returns a map of userId → Profile.
  /// Missing/failed profiles are omitted (caller uses fallback).
  TaskEither<ContactFailure, Map<String, Profile>> getProfilesByIds(
    Set<String> userIds,
  );

  TaskEither<ContactFailure, Profile> updateMyProfile({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? bio,
  });

  TaskEither<ContactFailure, List<Profile>> searchProfiles({
    int limit = 20,
    int offset = 0,
    String? usernamePrefix,
  });

  // ── Contact Requests ───────────────────────────────────────────────────────

  TaskEither<ContactFailure, ContactRequest> sendContactRequest({
    required String fromUser,
    required String toUser,
  });

  TaskEither<ContactFailure, List<ContactRequest>> listIncomingRequests(
    String userId,
  );

  TaskEither<ContactFailure, List<ContactRequest>> listOutgoingRequests(
    String userId,
  );

  TaskEither<ContactFailure, List<ContactRequest>> listAllMyRequests();

  TaskEither<ContactFailure, void> acceptContactRequest(String requestId);

  TaskEither<ContactFailure, void> rejectContactRequest(String requestId);

  TaskEither<ContactFailure, void> cancelContactRequest(String requestId);

  // ── Contacts ───────────────────────────────────────────────────────────────

  TaskEither<ContactFailure, List<Contact>> listMyContacts(String userId);

  TaskEither<ContactFailure, bool> isContact({
    required String userId,
    required String targetUserId,
  });

  TaskEither<ContactFailure, void> removeContact(String otherUserId);
}
