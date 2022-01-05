import 'dart:developer';

import 'package:logger/logger.dart';

class AppLogger {
  AppLogger.warning(
    this._message,
  ) {
    log(_message, level: Level.warning.index);
  }
  AppLogger.info(
    this._message,
  ) {
    log(_message, level: Level.info.index);
  }
  AppLogger.debug(
    this._message,
  ) {
    log(_message, level: Level.debug.index);
  }
  AppLogger.error(
    this._message,
  ) {
    log(_message, level: Level.error.index);
  }

  final String _message;
}
