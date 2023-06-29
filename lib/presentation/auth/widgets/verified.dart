import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:shimmer/shimmer.dart';

import '../../../application/user/profile/profile_bloc.dart';
import '../../../infrastructure/core/injection.dart';
import '../../routes/app_routes.dart';
import '../../shared_widgets/pill_button.dart';
import '../../shared_widgets/shimmers/title_shimmer_line.dart';
import '../../themes/constants.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) => getIt<ProfileBloc>()..add(GetUserProfile()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            body: Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    const SizedBox(height: 5),
                    if (state.userProfile != null) ...[
                      Text(
                        state.userProfile!.profile.fullName,
                        style: const TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ] else ...[
                      Shimmer.fromColors(
                        baseColor: Colors.black.withOpacity(0.1),
                        highlightColor: Colors.white.withOpacity(0.2),
                        child: Row(
                          children: [
                            TitleShimmerLine(
                              width: MediaQuery.of(context).size.width * 0.4,
                            ),
                            const SizedBox(width: 10),
                            TitleShimmerLine(
                              width: MediaQuery.of(context).size.width * 0.4,
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    const Text(
                      'Go ahead and change the world one crowdaction at a time!',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 40),
                    PillButton(
                      onTap: () => context.go(AppPage.home.path),
                      text: 'Go to CrowdActions',
                    ),
                    TextButton(
                      onPressed: () => context.go(AppPage.home.path),
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
            ),
          );
        },
      ),
    );
  }
}
