import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'i_logger.dart';

class DefaultLogger implements ILogger {
  final _logger = Logger('');

  @override
  Future<void> init() async {
    hierarchicalLoggingEnabled = true;

    if (kDebugMode) {
      _logger.level = Level.ALL;

      Logger.root.onRecord.listen((record) {
        final sb = StringBuffer(
          '[${_getLevelLabel(record.level.name)}]',
        );
        if (record.error != null && record.stackTrace != null) {
          if (record.loggerName.isNotEmpty) {
            sb.write(' [${record.loggerName}]');
          }
          sb
            ..write(' [${record.error}]')
            ..write(' Message: ${record.message}')
            ..write(' Exception: ${record.stackTrace}');
        } else if (record.error != null) {
          if (record.loggerName.isNotEmpty) {
            sb.write(' [${record.loggerName}]');
          }
          sb
            ..write(' [${record.error}]')
            ..write(' Message: ${record.message}');
        } else {
          if (record.loggerName.isNotEmpty) {
            sb.write(' [${record.loggerName}]');
          }
          sb.write(' Message: ${record.message}');
        }

        _debugPrintLong(sb.toString());
      });
    }

    if (kReleaseMode) {
      _logger.level = Level.OFF;
    }
  }

  @override
  void d({
    required String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (tag == null) {
      _logger.fine(message, error, stackTrace);
    } else {
      final l = Logger(tag);
      _logger.parent?.children.addAll({tag: l});
      l.fine(message, error, stackTrace);
    }
  }

  @override
  void e({
    required Object? error,
    String? message,
    String? tag,
    StackTrace? stackTrace,
  }) {
    if (tag == null) {
      _logger.severe(message, error, stackTrace);
    } else {
      final l = Logger(tag);
      _logger.parent?.children.addAll({tag: l});
      l.severe(message, error, stackTrace);
    }
  }

  @override
  void i({
    String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (tag == null) {
      _logger.info(message, error, stackTrace);
    } else {
      final l = Logger(tag);
      _logger.parent?.children.addAll({tag: l});
      l.info(message, error, stackTrace);
    }
  }

  @override
  void w({
    String? message,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (tag == null) {
      _logger.warning(message, error, stackTrace);
    } else {
      final l = Logger(tag);
      _logger.parent?.children.addAll({tag: l});
      l.warning(message, error, stackTrace);
    }
  }

  String _getLevelLabel(String levelName) {
    switch (levelName) {
      case 'FINE':
        return 'Debug';
      case 'INFO':
        return 'Info';
      case 'WARNING':
        return 'Warning';
      case 'SEVERE':
        return 'Error';
      default:
        return 'Verbose';
    }
  }

  void _debugPrintLong(String message, {int chunkSize = 1000}) {
    final pattern = RegExp('.{1,$chunkSize}'); // Split by chunks of chunkSize
    for (final chunk in pattern.allMatches(message)) {
      debugPrint(chunk.group(0)); // Print each chunk
    }
  }
}
