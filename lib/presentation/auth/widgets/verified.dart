import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../routes/app_routes.gr.dart';
import '../../shared_widgets/pill_button.dart';
import '../../themes/constants.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => getIt<ProfileBloc>()..add(GetUserProfile()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
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
                  if (state.userProfile != null) ...[
                    Text(
                      state.userProfile!.profile.fullName,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ] else ...[
                    const CircularProgressIndicator(),
                  ],
                  const SizedBox(height: 10),
                  const Text(
                    'Now go ahead and change the world one CrowdAction at a time',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: PillButton(
                      onTap: () =>
                          context.router.replaceAll([const HomeRoute()]),
                      text: 'Go to CrowdActions',
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.router.replaceAll([const HomeRoute()]),
                    child: const Text(
                      'Show me all CrowdActions',
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
      ),
    );
  }
}
