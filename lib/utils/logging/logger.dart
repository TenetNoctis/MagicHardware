import 'package:logger/logger.dart';

/// A utility class for logging messages throughout the application.
///
/// This class uses the `logger` package to provide a simple and consistent
/// way to log messages at different levels (debug, info, warning, error).
class MagicLoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
    level: Level.debug,
  );

  /// Logs a debug message.
  ///
  /// Use this for detailed information that is useful for debugging.
  static void debug(String message) {
    _logger.d(message);
  }

  /// Logs an informational message.
  ///
  /// Use this to log a message that is helpful to track the application flow.
  static void info(String message) {
    _logger.i(message);
  }

  /// Logs a warning message.
  ///
  /// Use this to log a potential issue that does not prevent the application from running.
  static void warning(String message) {
    _logger.w(message);
  }

  /// Logs an error message.
  ///
  /// Use this to log an error that has occurred, optionally with an error object and stack trace.
  static void error(String message, [dynamic error]) {
    _logger.e(message, error: error, stackTrace: StackTrace.current);
  }
}
