import 'package:flutter/material.dart';

/// A utility class to show native Material SnackBars from anywhere in the app.
class SnackbarUtil {
  /// A global key to display SnackBars without BuildContext.
  static final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  /// Shows a native SnackBar with optional action.
  ///
  /// [message]      The text to display in the snackbar.
  /// [isError]      If true, uses an error background (red); otherwise, default grey.
  /// [duration]     How long the snackbar stays visible. Defaults to 3 seconds.
  /// [actionLabel]  Label for the action button. If null, no button is shown.
  /// [onAction]     Callback when the action button is tapped.
  static void show({
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final bgColor = isError ? Colors.redAccent : Colors.grey[850];

    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: bgColor,
      duration: duration,
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(label: actionLabel, textColor: Colors.yellowAccent, onPressed: onAction)
          : null,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

    messengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  /// Convenience for info messages.
  static void info(String message, {String? actionLabel, VoidCallback? onAction, Duration duration = const Duration(seconds: 3)}) {
    show(message: message, isError: false, duration: duration, actionLabel: actionLabel, onAction: onAction);
  }

  /// Convenience for success messages.
  static void success(String message, {String? actionLabel, VoidCallback? onAction, Duration duration = const Duration(seconds: 3)}) {
    show(message: message, isError: false, duration: duration, actionLabel: actionLabel, onAction: onAction);
  }

  /// Convenience for error messages.
  static void error(String message, {String? actionLabel, VoidCallback? onAction, Duration duration = const Duration(seconds: 3)}) {
    show(message: message, isError: true, duration: duration, actionLabel: actionLabel, onAction: onAction);
  }
}
