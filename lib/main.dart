import 'package:flutter/material.dart';

import 'presentation/routes/app_routes.gr.dart' as app_router;
import 'presentation/themes/themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _appRouter = app_router.AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: lightTheme(context),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
