import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.gr.dart';
import '../shared_widgets/pill_button.dart';
import '../themes/constants.dart';
import '../../domain/core/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';

class UnauthenticatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAndMaybeShowOnboarding(context);
    });

    return Scaffold(
      backgroundColor: kAccentColor,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              "assets/images/unauthenticated_bg.png",
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Start acting",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We are ready, join us and others in taking action for a better life, by doing good and having fun!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 48),
              PillButton(
                text: 'Log In',
                isEnabled: true,
                isLoading: false,
                onTap: () => context.router.push(const AuthRoute()),
                lightBackground: true,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkAndMaybeShowOnboarding(BuildContext context) async {
    // Push onboarding screen if first time launching application
    final settingsRepository = getIt<ISettingsRepository>();
    if (!(await settingsRepository.getWasUserOnboarded())) {
      context.router.push(const OnboardingRoute());
    }
  }
}
