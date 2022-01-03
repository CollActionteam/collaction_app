import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';
import '../../infrastructure/core/injection.dart';

class ContentPlaceholder extends StatelessWidget {
  final Color textColor;
  const ContentPlaceholder({
    Key? key,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider<AuthBloc>(
        create: (context) =>
            getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final signedIn = state.maybeWhen(
              orElse: () => false,
              authenticated: (_) => true,
              unAuthenticated: () => false,
            );

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // TODO use giphy.com API or custom service for more variety and smaller builds
                  Image.asset(
                    'assets/images/content_placeholder.gif',
                    width: 125,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'There is nothing here',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!signedIn) ...[
                    const SizedBox(height: 5),
                    Text(
                      'We’re working hard on adding new content. In the meantime we have a happy dog for you \ud83d\ude09',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
