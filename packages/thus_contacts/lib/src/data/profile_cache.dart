import 'package:thus_contacts/src/data/models/profile.dart';

/// In-memory cache for resolved user profiles.
/// Keyed by userId. Thread-safe for single-isolate Flutter apps.
final class ProfileCache {
  ProfileCache();

  static final Profile unknown = Profile(
    userId: '',
    username: 'Unknown',
    displayName: 'Unknown User',
  );

  final Map<String, Profile> _cache = {};

  Profile? get(String userId) => _cache[userId];

  void put(String userId, Profile profile) => _cache[userId] = profile;

  bool has(String userId) => _cache.containsKey(userId);

  /// Returns cached profile or [unknown] fallback.
  Profile getOrFallback(String userId) => _cache[userId] ?? unknown;

  /// Returns the set of userIds NOT yet in cache.
  Set<String> missing(Iterable<String> userIds) =>
      userIds.where((id) => !_cache.containsKey(id)).toSet();
}
