import 'package:meta/meta.dart';

import 'failure.dart';

/// Generic use case signature for async operations.
abstract class UseCase<ReturnType, Params> {
  const UseCase();
  Future<ReturnType> call(Params params);
}

/// Convenience type for use cases that only return success or failure.
@immutable
class Result<T> {
  const Result.success(this.value)
      : failure = null,
        isSuccess = true;
  const Result.failure(this.failure)
      : value = null,
        isSuccess = false;

  final T? value;
  final Failure? failure;
  final bool isSuccess;
}

/// Marker for use cases without parameters.
@immutable
class NoParams {
  const NoParams();
}
