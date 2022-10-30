import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';
import '../../application/user/profile/profile_bloc.dart';
import '../../application/user/profile_tab/profile_tab_bloc.dart';
import '../../infrastructure/core/injection.dart';
import '../routes/app_routes.gr.dart';
import '../themes/themes.dart';

class AppWidget extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => getIt<ProfileBloc>()..add(GetUserProfile()),
        ),
        BlocProvider<ProfileTabBloc>(
          create: (_) => getIt<ProfileTabBloc>()..add(FetchProfileTabInfo()),
        )
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          BlocProvider.of<ProfileBloc>(context).add(GetUserProfile());
          BlocProvider.of<ProfileTabBloc>(context).add(FetchProfileTabInfo());
        },
        child: MaterialApp.router(
          color: Colors.white,
          title: 'CollAction',
          theme: lightTheme(context),
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
        ),
      ),
    );
  }
}
