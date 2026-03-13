import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:thus_core/thus_core.dart';

import '../../data/identity_repository.dart';
import '../entities/user_identity.dart';

class GenerateKeyPair extends UseCase<UserIdentity, String> {
  GenerateKeyPair(this._repository);

  final IdentityRepository _repository;
  final KeyPairType _algorithm = Cryptography.instance.ed25519();

  @override
  Future<UserIdentity> call(String displayName) async {
    final keyPair = await _algorithm.newKeyPair();
    final publicKey = await keyPair.extractPublicKey();
    final publicKeyBytes = publicKey.bytes;
    final privateKeyBytes = await keyPair.extractPrivateKeyBytes();

    final pubKey = base64UrlEncode(publicKeyBytes);
    final privKey = base64UrlEncode(privateKeyBytes);
    final id = base64UrlEncode(publicKeyBytes).substring(0, 24);

    final identity = UserIdentity(
      id: id,
      publicKey: pubKey,
      privateKey: privKey,
      displayName: displayName,
    );
    await _repository.save(identity);
    return identity;
  }
}
