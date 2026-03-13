import 'package:hive_ce/hive.dart';

import 'hive_initializer.dart';

/// Generic cache abstraction over Hive boxes.
class CacheRepository<T> {
  CacheRepository(this._initializer, {required this.boxName, this.encrypted = false});

  final HiveInitializer _initializer;
  final String boxName;
  final bool encrypted;

  Future<void> write(String key, T value) async {
    final box = await _initializer.openBox<T>(boxName, encrypted: encrypted);
    await box.put(key, value);
  }

  Future<T?> read(String key) async {
    final box = await _initializer.openBox<T>(boxName, encrypted: encrypted);
    return box.get(key);
  }

  Future<List<T>> readAll() async {
    final box = await _initializer.openBox<T>(boxName, encrypted: encrypted);
    return box.values.toList(growable: false);
  }

  Future<void> remove(String key) async {
    final box = await _initializer.openBox<T>(boxName, encrypted: encrypted);
    await box.delete(key);
  }

  Stream<List<T>> watchAll() async* {
    final box = await _initializer.openBox<T>(boxName, encrypted: encrypted);
    yield box.values.toList(growable: false);
    await for (final _ in box.watch()) {
      yield box.values.toList(growable: false);
    }
  }
}
