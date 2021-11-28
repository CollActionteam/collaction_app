import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../../domain/auth/i_auth_repository.dart';
import '../../../domain/user/user.dart';
import '../../../infrastructure/core/injection.dart';
import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/rectangle_button.dart';
import '../../themes/constants.dart';

class VerifiedPage extends StatefulWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  final _userRepository = getIt<IAuthRepository>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          body: Align(
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tight(const Size(150, 150)),
                  child: const RiveAnimation.asset(
                    'assets/animations/verified.riv',
                  ),
                ),
                const Text(
                  'You are all set',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                StreamBuilder(
                  stream: _userRepository.observeUser(),
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData) {
                      final name = snapshot.data?.displayName ?? "";

                      return Text(
                        name,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }

                    return const CircularProgressIndicator();
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  'Now go ahead and change the world one crowdaction at a time',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9),
                  child: RectangleButton(
                    onTap: () => context.router.popUntilRoot(),

                    /// TODO: Verify if this is correct! (should return to homescreen)
                    text: 'Go to crowdactions',
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      context.router.push(const HomeRoute()),
                  child: const Text(
                    'Show me all crowdactions',
                    style: TextStyle(
                      color: kAccentColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
