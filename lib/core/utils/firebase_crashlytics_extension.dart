import 'package:firebase_crashlytics/firebase_crashlytics.dart';

extension FirebaseCrashlyticsLogger on FirebaseCrashlytics {
  static Future<void> log(String message) async {
    FirebaseCrashlytics.instance.log(message);
  }

  static Future<void> warn(
    Exception exception,
    StackTrace? stackTrace, {
    String? message,
    bool fatal = false,
  }) async {
    FirebaseCrashlytics.instance.recordError(
      exception,
      stackTrace,
      reason: message,
      fatal: fatal,
    );
  }
}
