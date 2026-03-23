import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failure.freezed.dart';

@Freezed(copyWith: false)
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.network({
    required int? code,
    required String message,
    required StackTrace stackTrace,
  }) = AuthNetworkFailure;

  const factory AuthFailure.unauthorized({
    required int? code,
    required String message,
    required StackTrace stackTrace,
  }) = AuthUnauthorizedFailure;

  const factory AuthFailure.storage({
    required int? code,
    required String message,
    required StackTrace stackTrace,
  }) = AuthStorageFailure;

  const factory AuthFailure.other({
    required int? code,
    required String message,
    required StackTrace stackTrace,
  }) = AuthOtherFailure;
}
