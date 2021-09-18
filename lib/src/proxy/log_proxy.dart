import 'dart:developer' as $dev;

mixin LoggerProxy {
  void logD(String tag, String message);

  void logI(String tag, String message);

  void logW(String tag, String message);

  void logE(String tag, String message);
}

/// Global log entry
final log = Logger._(_DefaultLoggerProxy());

class Logger {
  Logger._(LoggerProxy proxy) : _proxy = proxy;

  LoggerProxy? _proxy;

  set proxy(LoggerProxy proxy) => _proxy = proxy;

  void d(String tag, String message) => _proxy?.logD(tag, message);

  void i(String tag, String message) => _proxy?.logI(tag, message);

  void w(String tag, String message) => _proxy?.logW(tag, message);

  void e(String tag, String message) => _proxy?.logE(tag, message);
}

class _DefaultLoggerProxy with LoggerProxy {
  @override
  void logD(String tag, String message) => _debugLog(tag, message, Level.debug);

  @override
  void logI(String tag, String message) => _debugLog(tag, message, Level.info);

  @override
  void logW(String tag, String message) =>
      _debugLog(tag, message, Level.warning);

  @override
  void logE(String tag, String message) => _debugLog(tag, message, Level.error);

  void _debugLog(String tag, String message, int level) =>
      $dev.log(message, level: level, name: tag);
}

class Level {
  Level._();

  static const debug = 500;
  static const info = 800;
  static const warning = 900;
  static const error = 1000;
}
