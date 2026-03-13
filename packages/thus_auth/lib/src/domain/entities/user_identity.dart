import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'user_identity.freezed.dart';
part 'user_identity.g.dart';

@freezed
class UserIdentity with _$UserIdentity {
  @HiveType(typeId: 1, adapterName: 'UserIdentityAdapter')
  const factory UserIdentity({
    @HiveField(0) required String id,
    @HiveField(1) required String publicKey,
    @HiveField(2) required String displayName,
    // Private key is optional so that production builds can back it with OS key stores.
    @HiveField(3) String? privateKey,
  }) = _UserIdentity;

  factory UserIdentity.fromJson(Map<String, dynamic> json) => _$UserIdentityFromJson(json);
}
