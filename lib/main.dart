import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'domain/core/i_settings_repository.dart';
import 'infrastructure/core/injection.dart';
import 'presentation/core/app_widget.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      configureInjection();
      getIt<ISettingsRepository>();

      await Firebase.initializeApp();
      await dotenv.load();

      if (dotenv.env['SENTRY_URI'] != null) {
        await SentryFlutter.init(
          (options) {
            options.dsn = dotenv.env['SENTRY_URI'];
            options.tracesSampleRate = kReleaseMode ? 0.4 : 1.0;
          },
          appRunner: () => runApp(AppWidget()),
        );
      } else {
        runApp(AppWidget());
      }
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}
