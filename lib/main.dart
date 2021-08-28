import 'package:flutter/material.dart';

import 'infrastructure/core/injection.dart';
import 'presentation/routes/app_routes.gr.dart' as app_router;
import 'presentation/themes/themes.dart';

void main() {
  configureInjection();

  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  final _appRouter = app_router.AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      color: Colors.white,
      title: 'CollAction',
      theme: lightTheme(context),
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
