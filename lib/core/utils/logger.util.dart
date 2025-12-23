import 'dart:developer' as developer;
import 'package:clipcraft/core/constants/app_config.constants.dart';
import 'package:flutter/foundation.dart';

/// Utility class for logging in the application
class Logger {
  Logger._(); // Private constructor to prevent instantiation

  /// The default "subsystem" or "tag" used for all logs.
  /// Feel free to override at runtime if you want to group logs differently.
  static String tag = AppConfigConstants.appName;

  /// In debug builds, debug‐level logging is enabled. In release, it's off.
  static bool get _enableDebug => kDebugMode;

  /// Info is enabled in debug or profile builds.
  static bool get _enableInfo => kDebugMode || kProfileMode;

  /// Always allow warnings.
  static bool get _enableWarning => true;

  /// Always allow errors.
  static bool get _enableError => true;

  // ────────────────────────────────────────────────────────────────────────────
  // PUBLIC API (all static)
  // ────────────────────────────────────────────────────────────────────────────

  /// Logs a debug-level message. No-op in release builds.
  static void debug(String message, {String? name, Object? error, StackTrace? stackTrace, int? level}) {
    if (!_enableDebug) return;
    _log(
      message: message,
      name: name ?? tag,
      error: error,
      stackTrace: stackTrace,
      level: level ?? 500, // convention: <1000 is “debug/verbose”
    );
  }

  /// Logs an informational message. No-op in release (unless in profile).
  static void info(String message, {String? name, Object? error, StackTrace? stackTrace, int? level}) {
    if (!_enableInfo) return;
    _log(
      message: message,
      name: name ?? tag,
      error: error,
      stackTrace: stackTrace,
      level: level ?? 800, // convention: 800–899 is “info”
    );
  }

  /// Logs a warning. Always printed, even in release.
  static void warning(String message, {String? name, Object? error, StackTrace? stackTrace, int? level}) {
    if (!_enableWarning) return;
    _log(
      message: message,
      name: name ?? tag,
      error: error,
      stackTrace: stackTrace,
      level: level ?? 900, // convention: 900–999 is “warning”
    );
  }

  /// Logs an error/fatal. Always printed. You can pass an [error]
  /// and [stackTrace] for more context.
  static void error(String message, {String? name, Object? error, StackTrace? stackTrace, int? level}) {
    if (!_enableError) return;
    _log(
      message: message,
      name: name ?? tag,
      error: error,
      stackTrace: stackTrace,
      level: level ?? 1000, // convention: ≥1000 is “error/fatal”
    );
  }

  // ────────────────────────────────────────────────────────────────────────────
  // PRIVATE: routes through dart:developer.log + stdout
  // ────────────────────────────────────────────────────────────────────────────

  static void _log({required String message, required String name, Object? error, StackTrace? stackTrace, required int level}) {
    // 1) dart:developer.log: so Flutter DevTools (or Observatory) can pick it up.
    developer.log(message, name: name, error: error, stackTrace: stackTrace, level: level);

    // 2) print to console in a simple tagged format with timestamp.
    final prefix = _prefixForLevel(level);
    final timestamp = DateTime.now().toIso8601String();
    print('[$timestamp] [$name] $prefix $message');

    // 3) (Optional) If you want to forward to a remote crash-reporting service,
    //    you could add it here (e.g. Sentry.captureException(error, stackTrace: stackTrace)).
  }

  /// Returns a short string (“DEBUG:”, “INFO:”, etc.) based on the numeric level.
  static String _prefixForLevel(int level) {
    if (level >= 1000) {
      return 'ERROR:';
    } else if (level >= 900) {
      return 'WARNING:';
    } else if (level >= 800) {
      return 'INFO:';
    } else {
      return 'DEBUG:';
    }
  }
}
