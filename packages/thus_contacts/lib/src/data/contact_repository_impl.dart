import 'package:fpdart/fpdart.dart';
import 'package:thus_auth/thus_auth.dart';
import 'package:thus_core/thus_core.dart';
import 'package:thus_network/thus_network.dart';

import 'package:thus_contacts/src/data/contact_repository.dart';
import 'package:thus_contacts/src/data/models/contact.dart';
import 'package:thus_contacts/src/data/models/contact_failure.dart';
import 'package:thus_contacts/src/data/models/contact_request.dart';
import 'package:thus_contacts/src/data/models/profile.dart';

final class ContactRepositoryImpl implements ContactRepository {
  ContactRepositoryImpl({
    required RestClient restClient,
    required AuthRepository authRepository,
  })  : _restClient = restClient,
        _authRepository = authRepository;

  final RestClient _restClient;
  final AuthRepository _authRepository;

  // ── Profiles ──────────────────────────────────────────────────────────────

  @override
  TaskEither<ContactFailure, Profile> getMyProfile(String userId) {
    return _withSession((session) async {
      final list = await _restClient.getJsonList(
        AppConstants.restProfilesPath,
        query: {
          'user_id': 'eq.$userId',
          'select': 'user_id,username,display_name,avatar_url,bio,updated_at',
        },
        headers: _bearer(session.accessToken),
      );
      final item = _firstOrThrow(list, 'Profile not found');
      return Profile.fromJson(_castMap(item));
    });
  }

  @override
  TaskEither<ContactFailure, Profile> getProfileByUsername(String username) {
    return _withSession((session) async {
      final list = await _restClient.getJsonList(
        AppConstants.restProfilesPath,
        query: {
          'username': 'eq.$username',
          'select': 'user_id,username,display_name,avatar_url,bio',
        },
        headers: _bearer(session.accessToken),
      );
      final item = _firstOrThrow(list, 'Profile not found');
      return Profile.fromJson(_castMap(item));
    });
  }

  @override
  TaskEither<ContactFailure, Profile> getProfileById(String userId) {
    return _withSession((session) async {
      final list = await _restClient.getJsonList(
        AppConstants.restProfilesPath,
        query: {
          'user_id': 'eq.$userId',
          'select': 'user_id,username,display_name,avatar_url,bio',
        },
        headers: _bearer(session.accessToken),
      );
      final item = _firstOrThrow(list, 'Profile not found');
      return Profile.fromJson(_castMap(item));
    });
  }

  @override
  TaskEither<ContactFailure, Profile> updateMyProfile({
    required String userId,
    String? displayName,
    String? avatarUrl,
    String? bio,
  }) {
    return _withSession((session) async {
      final body = <String, dynamic>{
        if (displayName != null) 'display_name': displayName,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
        if (bio != null) 'bio': bio,
      };
      await _restClient.patch(
        AppConstants.restProfilesPath,
        data: body,
        query: {'user_id': 'eq.$userId'},
        headers: _bearer(session.accessToken),
      );
      // Re-fetch updated profile; fallback to minimal stub if fetch fails
      final fetchResult = await getMyProfile(userId).run();
      return fetchResult.getOrElse(
        (_) => Profile(userId: userId, username: session.userId),
      );
    });
  }

  @override
  TaskEither<ContactFailure, List<Profile>> searchProfiles({
    int limit = 20,
    int offset = 0,
    String? usernamePrefix,
  }) {
    return _withSession((session) async {
      final query = <String, dynamic>{
        'select': 'user_id,username,display_name,avatar_url',
        'limit': '$limit',
        'offset': '$offset',
        if (usernamePrefix != null) 'username': 'like.$usernamePrefix%',
      };
      final list = await _restClient.getJsonList(
        AppConstants.restProfilesPath,
        query: query,
        headers: _bearer(session.accessToken),
      );
      return (list ?? []).map((e) => Profile.fromJson(_castMap(e))).toList();
    });
  }

  // ── Contact Requests ───────────────────────────────────────────────────────

  @override
  TaskEither<ContactFailure, ContactRequest> sendContactRequest({
    required String fromUser,
    required String toUser,
  }) {
    return _withSession((session) async {
      final list = await _restClient.postJsonList(
        AppConstants.restContactRequestsPath,
        data: {
          'from_user': fromUser,
          'to_user': toUser,
          'status': 'pending',
        },
        headers: _bearer(session.accessToken),
      );
      final item = _firstOrThrow(list, 'Contact request not created');
      return ContactRequest.fromJson(_castMap(item));
    });
  }

  @override
  TaskEither<ContactFailure, List<ContactRequest>> listIncomingRequests(
    String userId,
  ) {
    return _withSession((session) async {
      final list = await _restClient.getJsonList(
        AppConstants.restContactRequestsPath,
        query: {
          'to_user': 'eq.$userId',
          'status': 'eq.pending',
          'select': 'id,from_user,created_at',
          'order': 'created_at.desc',
        },
        headers: _bearer(session.accessToken),
      );
      return (list ?? [])
          .map((e) => ContactRequest.fromJson(_castMap(e)))
          .toList();
    });
  }

  @override
  TaskEither<ContactFailure, List<ContactRequest>> listOutgoingRequests(
    String userId,
  ) {
    return _withSession((session) async {
      final list = await _restClient.getJsonList(
        AppConstants.restContactRequestsPath,
        query: {
          'from_user': 'eq.$userId',
          'status': 'eq.pending',
          'select': 'id,to_user,created_at',
          'order': 'created_at.desc',
        },
        headers: _bearer(session.accessToken),
      );
      return (list ?? [])
          .map((e) => ContactRequest.fromJson(_castMap(e)))
          .toList();
    });
  }

  @override
  TaskEither<ContactFailure, List<ContactRequest>> listAllMyRequests() {
    return _withSession((session) async {
      final list = await _restClient.getJsonList(
        AppConstants.restContactRequestsPath,
        query: {
          'select': 'id,from_user,to_user,status,created_at',
          'order': 'created_at.desc',
          'limit': '50',
        },
        headers: _bearer(session.accessToken),
      );
      return (list ?? [])
          .map((e) => ContactRequest.fromJson(_castMap(e)))
          .toList();
    });
  }

  @override
  TaskEither<ContactFailure, void> acceptContactRequest(String requestId) {
    return _withSession((session) async {
      await _restClient.postJson(
        AppConstants.rpcAcceptContactRequest,
        data: {'req_id': requestId},
        headers: _bearer(session.accessToken),
      );
    });
  }

  @override
  TaskEither<ContactFailure, void> rejectContactRequest(String requestId) {
    return _withSession((session) async {
      await _restClient.postJson(
        AppConstants.rpcRejectContactRequest,
        data: {'req_id': requestId},
        headers: _bearer(session.accessToken),
      );
    });
  }

  @override
  TaskEither<ContactFailure, void> cancelContactRequest(String requestId) {
    return _withSession((session) async {
      await _restClient.delete(
        AppConstants.restContactRequestsPath,
        query: {
          'id': 'eq.$requestId',
          'status': 'eq.pending',
        },
        headers: _bearer(session.accessToken),
      );
    });
  }

  // ── Contacts ───────────────────────────────────────────────────────────────

  @override
  TaskEither<ContactFailure, List<Contact>> listMyContacts(String userId) {
    return _withSession((session) async {
      final list = await _restClient.getJsonList(
        AppConstants.restContactsPath,
        query: {
          'user_id': 'eq.$userId',
          'select': 'contact_id,created_at',
          'order': 'created_at.desc',
          'limit': '100',
        },
        headers: _bearer(session.accessToken),
      );
      return (list ?? []).map((e) => Contact.fromJson(_castMap(e))).toList();
    });
  }

  @override
  TaskEither<ContactFailure, bool> isContact({
    required String userId,
    required String targetUserId,
  }) {
    return _withSession((session) async {
      final list = await _restClient.getJsonList(
        AppConstants.restContactsPath,
        query: {
          'user_id': 'eq.$userId',
          'contact_id': 'eq.$targetUserId',
          'select': 'contact_id,created_at',
        },
        headers: _bearer(session.accessToken),
      );
      return (list ?? []).isNotEmpty;
    });
  }

  @override
  TaskEither<ContactFailure, void> removeContact(String otherUserId) {
    return _withSession((session) async {
      await _restClient.postJson(
        AppConstants.rpcRemoveContact,
        data: {'other_user': otherUserId},
        headers: _bearer(session.accessToken),
      );
    });
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  TaskEither<ContactFailure, T> _withSession<T>(
    Future<T> Function(AuthSession session) fn,
  ) {
    return TaskEither.tryCatch(
      () async {
        final result = await _authRepository.loadSession().run();
        final session = result.match(
          (f) => throw StateError(f.toString()),
          (s) {
            if (s == null) throw StateError('Not authenticated.');
            return s;
          },
        );
        return fn(session);
      },
      (error, stackTrace) => ContactNetworkFailure(
        code: null,
        message: error.toString(),
        stackTrace: stackTrace,
      ),
    );
  }

  Map<String, String> _bearer(String token) =>
      {'Authorization': 'Bearer $token'};

  Map<String, dynamic> _castMap(dynamic raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map<Object?, Object?>) {
      return raw.map((k, v) => MapEntry(k.toString(), v));
    }
    return {};
  }

  dynamic _firstOrThrow(List<dynamic>? list, String errorMessage) {
    if (list == null || list.isEmpty) throw StateError(errorMessage);
    return list.first;
  }
}
