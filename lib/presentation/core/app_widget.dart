import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/crowdaction/subscription/subscription_bloc.dart';
import '../../application/auth/auth_bloc.dart';
import '../../application/crowdaction/subscription/status/subscription_status_bloc.dart';
import '../../infrastructure/core/injection.dart';
import '../routes/app_routes.gr.dart';
import '../themes/themes.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();

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
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
