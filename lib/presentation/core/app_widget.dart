import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';
import '../../application/user/profile/profile_bloc.dart';
import '../../application/user/profile_tab/profile_tab_bloc.dart';
import '../../infrastructure/core/injection.dart';

import '../routes/app_routes.dart';
import '../themes/themes.dart';

class AppWidget extends StatelessWidget {
  final AppRouter appRouter;

  const AppWidget({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) =>
              appRouter.authBloc..add(AuthEvent.authCheckRequested()),
        ),
        BlocProvider<ProfileBloc>(create: (_) => getIt<ProfileBloc>()),
        BlocProvider<ProfileTabBloc>(create: (_) => getIt<ProfileTabBloc>())
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) {
              BlocProvider.of<ProfileBloc>(context).add(GetUserProfile());
              BlocProvider.of<ProfileTabBloc>(context)
                  .add(FetchProfileTabInfo());
            },
            loggedIn: (_) {
              BlocProvider.of<ProfileBloc>(context).add(GetUserProfile());
              BlocProvider.of<ProfileTabBloc>(context)
                  .add(FetchProfileTabInfo());
            },
            orElse: () {},
          );
        },
        child: MaterialApp.router(
          color: Colors.white,
          title: 'CollAction',
          theme: lightTheme(),
          routerConfig: appRouter.router,
        ),
      ),
    );
  }
}
