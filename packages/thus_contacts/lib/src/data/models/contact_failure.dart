sealed class ContactFailure {
  const ContactFailure({required this.message, required this.stackTrace});

  final String message;
  final StackTrace stackTrace;

  @override
  String toString() => '$runtimeType: $message';
}

final class ContactNetworkFailure extends ContactFailure {
  const ContactNetworkFailure({
    required super.message,
    required super.stackTrace,
    this.code,
  });

  final int? code;
}

final class ContactStorageFailure extends ContactFailure {
  const ContactStorageFailure({
    required super.message,
    required super.stackTrace,
    this.code,
  });

  final int? code;
}

final class ContactOtherFailure extends ContactFailure {
  const ContactOtherFailure({
    required super.message,
    required super.stackTrace,
    this.code,
  });

  final int? code;
}
