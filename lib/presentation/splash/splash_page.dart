import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.mapOrNull(
          authenticated: (_) => AutoRouter.of(context).replaceAll([
            const HomeRoute(),
          ]),
          unAuthenticated: (_) => AutoRouter.of(context).replaceAll([
            const AuthRoute(),
          ]),
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
