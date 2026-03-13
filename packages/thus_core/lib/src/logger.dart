import 'dart:developer' as developer;

enum LogLevel { debug, info, warning, error }

/// Lightweight logger that can be swapped for any implementation.
class AppLogger {
  const AppLogger();

  void log(String message, {LogLevel level = LogLevel.info, Object? error, StackTrace? stackTrace}) {
    developer.log('[${level.name.toUpperCase()}] $message', error: error, stackTrace: stackTrace);
  }
}
