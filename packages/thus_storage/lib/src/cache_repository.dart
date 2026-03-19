import 'dart:convert';

import 'package:hive_ce/hive.dart';

import 'hive_initializer.dart';

typedef JsonDecoder<T> = T Function(Map<String, dynamic> json);
typedef JsonEncoder<T> = Map<String, dynamic> Function(T value);

/// Generic cache abstraction over Hive boxes using JSON serialization.
class CacheRepository<T> {
  CacheRepository(
    this._initializer, {
    required this.boxName,
    required JsonDecoder<T> fromJson,
    required JsonEncoder<T> toJson,
    this.encrypted = false,
  }) : _fromJson = fromJson,
       _toJson = toJson;

  final HiveInitializer _initializer;
  final String boxName;
  final JsonDecoder<T> _fromJson;
  final JsonEncoder<T> _toJson;
  final bool encrypted;

  Future<void> write(String key, T value) async {
    final Box<String> box = await _openBox();
    final String payload = jsonEncode(_toJson(value));
    await box.put(key, payload);
  }

  Future<T?> read(String key) async {
    final Box<String> box = await _openBox();
    return _decode(box.get(key));
  }

  Future<List<T>> readAll() async {
    final Box<String> box = await _openBox();
    return box.values.map(_decodeRequired).toList(growable: false);
  }

  Future<void> remove(String key) async {
    final Box<String> box = await _openBox();
    await box.delete(key);
  }

  Future<void> clear() async {
    final Box<String> box = await _openBox();
    await box.clear();
  }

  Stream<List<T>> watchAll() async* {
    final Box<String> box = await _openBox();
    yield box.values.map(_decodeRequired).toList(growable: false);

    await for (final BoxEvent _ in box.watch()) {
      yield box.values.map(_decodeRequired).toList(growable: false);
    }
  }

  Future<Box<String>> _openBox() {
    return _initializer.openBox(boxName, encrypted: encrypted);
  }

  T? _decode(String? raw) {
    if (raw == null) {
      return null;
    }

    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;
    return _fromJson(json);
  }

  T _decodeRequired(String raw) {
    return _decode(raw)!;
  }
}
