import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/auth/auth_bloc.dart';
import '../../infrastructure/core/injection.dart';
import 'pill_button.dart';

class ContentPlaceholder extends StatelessWidget {
  final Color textColor;
  final String? description;
  const ContentPlaceholder({
    Key? key,
    required this.textColor,
    this.description,
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
              authenticated: () => true,
              unAuthenticated: () => false,
            );

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/content_placeholder.png',
                    width: 125,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Nothing to see here',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      description!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                  ],
                  if (!signedIn) ...[
                    const SizedBox(height: 5),
                    Text(
                      'How about creating an account in the meantime?',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                        color: textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    PillButton(
                      text: "Create account",
                      onTap: () {
                        /// TODO: Add onTap here
                      },
                    ),
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
