import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application/auth/auth_bloc.dart';
import 'domain/core/i_settings_repository.dart';
import 'infrastructure/core/injection.dart';
import 'presentation/core/app_widget.dart';
import 'presentation/routes/app_routes.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      configureInjection();
      getIt<ISettingsRepository>();

      await Firebase.initializeApp();
      await dotenv.load();

      final appRouter = AppRouter(
        authBloc: getIt<AuthBloc>(),
        settingsRepo: getIt<ISettingsRepository>(),
      );

      runApp(AppWidget(appRouter: appRouter));
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}
