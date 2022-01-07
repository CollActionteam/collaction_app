import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/subscription/subscription_bloc.dart';
import '../../application/auth/auth_bloc.dart';
import '../../application/crowdaction/subscription_status/subscription_status_bloc.dart';
import '../../infrastructure/core/injection.dart';
import '../routes/app_routes.gr.dart';
import '../themes/themes.dart';
import '../utils/mvp.dart';

class AppWidget extends StatefulWidget {
  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final _appRouter = AppRouter();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (Timer timer) =>
          checkAndMaybeShowCaptivePage(_appRouter).then((wasCaptivePageShown) {
        if (wasCaptivePageShown) {
          timer.cancel();
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SubscriptionBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SubscriptionStatusBloc>(),
        )
      ],
      child: MaterialApp.router(
        color: Colors.white,
        title: 'CollAction',
        theme: lightTheme(context),
        // Do NOT hide banner in debug mode to distinguish between release and non-release builds!
        // debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
