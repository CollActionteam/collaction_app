import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.gr.dart';
import '../shared_widgets/pill_button.dart';
import '../themes/constants.dart';
import '../../domain/core/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';

class UnauthenticatedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return UnauthenticatedPageState();
  }
}

class UnauthenticatedPageState extends State<UnauthenticatedPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAndMaybeShowOnboarding();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentColor,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 23,
                  child: Image.asset(
                    "assets/images/unauthenticated_bg.png",
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 200,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Start acting",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 64.0, left: 16, right: 16, top: 8),
                    child: Text(
                      "We are ready, join us and others in taking action for a better life, by doing good and having fun!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 100.0, left: 20, right: 20),
                          child: PillButton(
                            text: 'Log In',
                            isEnabled: true,
                            isLoading: false,
                            onTap: () => context.router.push(const AuthRoute()),
                            lightBackground: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkAndMaybeShowOnboarding() async {
    // Push onboarding screen if first time launching application
    final settingsRepository = getIt<ISettingsRepository>();
    if (!(await settingsRepository.getWasUserOnboarded())) {
      context.router.push(const OnboardingRoute());
    }
  }
}
