abstract class ILogger {
  Future<void> init();

  /// Log an info exception and a message with optional format args.
  /// [tag] Explicit tag. May be `null`.
  /// [message] Formatted log message.
  /// [error] Accompanying exceptions. May be `null`.
  void i({
    required String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Log a debug exception and a message with optional format args.
  /// [tag] Explicit tag. May be `null`.
  /// [message] Formatted log message.
  /// [error] Accompanying exceptions. May be `null`.
  void d({
    required String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Log a warning exception and a message with optional format args.
  /// [tag] Explicit tag. May be `null`.
  /// [message] Formatted log message.
  /// [error] Accompanying exceptions. May be `null`.
  void w({
    required String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  });

  /// Log an error exception and a message with optional format args.
  /// [tag] Explicit tag. May be `null`.
  /// [message] Formatted log message.
  /// [error] Accompanying exceptions. May be `null`.
  void e({
    required Object? error,
    String? message,
    String? tag,
    StackTrace? stackTrace,
  });
}
