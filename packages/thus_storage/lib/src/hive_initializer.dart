import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:thus_core/thus_core.dart';

/// Handles Hive initialization and encrypted box creation.
class HiveInitializer {
  HiveInitializer({required AppLogger logger}) : _logger = logger;

  final AppLogger _logger;
  HiveAesCipher? _cipher;
  bool _initialized = false;

  Future<void> init({List<int>? encryptionKey}) async {
    if (_initialized) return;

    final Directory dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);

    final key = encryptionKey ?? Hive.generateSecureKey();
    _cipher = HiveAesCipher(key);
    _initialized = true;
    _logger.log('Hive initialized at ${dir.path}', level: LogLevel.info);
  }

  HiveAesCipher? get cipher => _cipher;

  Future<Box<T>> openBox<T>(String name, {bool encrypted = false}) async {
    if (!_initialized) {
      await init();
    }

    if (encrypted) {
      return Hive.openBox<T>(name, encryptionCipher: _cipher);
    }
    return Hive.openBox<T>(name);
  }
}
