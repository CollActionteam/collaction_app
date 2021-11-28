import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'domain/core/i_settings_repository.dart';
import 'infrastructure/core/injection.dart';
import 'presentation/core/app_widget.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

      configureInjection();
      getIt<ISettingsRepository>();

      FirebaseCrashlytics.instance.crash();

      runApp(AppWidget());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}
