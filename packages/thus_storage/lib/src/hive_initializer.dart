import 'dart:convert';
import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:thus_core/thus_core.dart';

/// Handles Hive initialization and persists the encryption key across restarts.
class HiveInitializer {
  HiveInitializer({required AppLogger logger}) : _logger = logger;

  final AppLogger _logger;

  HiveAesCipher? _cipher;
  Directory? _storageDirectory;
  bool _initialized = false;

  Future<void> init({
    required String storagePath,
    List<int>? encryptionKey,
  }) async {
    if (_initialized) {
      return;
    }

    final Directory directory = Directory(storagePath);
    await directory.create(recursive: true);

    Hive.init(directory.path);

    final List<int> resolvedKey =
        encryptionKey ?? await _loadOrCreateKey(directory);
    _cipher = HiveAesCipher(resolvedKey);
    _storageDirectory = directory;
    _initialized = true;

    _logger.log('Hive initialized at ${directory.path}', level: LogLevel.info);
  }

  Future<Box<String>> openBox(String name, {bool encrypted = false}) async {
    _ensureInitialized();

    if (encrypted) {
      return Hive.openBox<String>(name, encryptionCipher: _cipher);
    }

    return Hive.openBox<String>(name);
  }

  Directory get storageDirectory {
    _ensureInitialized();
    return _storageDirectory!;
  }

  void _ensureInitialized() {
    if (!_initialized || _storageDirectory == null) {
      throw StateError(
        'HiveInitializer.init must be called before opening a box.',
      );
    }
  }

  Future<List<int>> _loadOrCreateKey(Directory directory) async {
    final File keyFile = File(
      '${directory.path}/${AppConstants.hiveEncryptionKeyFileName}',
    );

    if (await keyFile.exists()) {
      final String rawValue = await keyFile.readAsString();
      return base64Url.decode(rawValue);
    }

    final List<int> generatedKey = Hive.generateSecureKey();
    await keyFile.writeAsString(base64Url.encode(generatedKey), flush: true);
    return generatedKey;
  }
}
