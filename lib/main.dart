import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'domain/i_settings_repository.dart';
import 'infrastructure/core/injection.dart';
import 'presentation/core/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  configureInjection();
  // Instantiate to trigger update of remote configs
  getIt<ISettingsRepository>();

  runApp(AppWidget());
}
