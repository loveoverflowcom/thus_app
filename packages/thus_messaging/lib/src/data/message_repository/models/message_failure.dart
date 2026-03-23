import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_failure.freezed.dart';

@Freezed(copyWith: false)
sealed class MessageFailure with _$MessageFailure {
  const factory MessageFailure.network({
    required int? code,
    required String message,
    required StackTrace stackTrace,
  }) = MessageNetworkFailure;

  const factory MessageFailure.storage({
    required int? code,
    required String message,
    required StackTrace stackTrace,
  }) = MessageStorageFailure;

  const factory MessageFailure.other({
    required int? code,
    required String message,
    required StackTrace stackTrace,
  }) = MessageOtherFailure;
}
