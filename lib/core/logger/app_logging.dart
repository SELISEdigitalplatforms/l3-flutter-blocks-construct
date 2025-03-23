import 'package:flutter/foundation.dart';

import 'src/default_logger.dart';
import 'src/i_logger.dart';

/// Provides access to the application's logger instance.
///
/// The logger is initialized asynchronously based on the app's build mode.
/// In release mode, a [FirebaseLogger] is used, while in debug mode a
/// [DefaultLogger] is used.
/// The logger instance is lazily initialized and cached, so that it can be
/// accessed throughout the app without needing to worry about initialization.
///
/// To use the logger, call the [logger] getter, which will return the
/// initialized logger instance.
/// If the logger has not been initialized yet, it will throw an exception.
///
/// Example usage:
/// logger.info('This is an informational message');
/// logger.error('This is an error message');
///
ILogger? _logger;

ILogger get logger => _logger ?? DefaultLogger();

Future<void> initLogger() async {
  if (!kReleaseMode) {
    final logger = DefaultLogger();
    await logger.init();
    _logger = logger;
  }
}
