import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/core/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';
import '../../presentation/shared_widgets/no_ripple_behavior.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.dart';
import '../themes/constants.dart';
import 'widgets/onboarding_step.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  double currentPage = 0;

  final settingsRepository = getIt<ISettingsRepository>();

  final imagePages = [
    CollactionIcons.goal,
    CollactionIcons.crowd,
    CollactionIcons.collaction,
  ];

  final titlePages = [
    "Goal",
    "Crowd",
    "Action",
  ];

  final textPages = [
    "Choose or suggest a challenge you want to participate in",
    "See how your actions are amplified by a crowd with similar goals",
    "Commit to the challenge and make impact together",
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != currentPage) {
        setState(() {
          currentPage = _pageController.page!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.height > 700 ? 1.0 : 0.8;

    return WillPopScope(
      // Prevent closing the tutorial before it was completed
      onWillPop: () async => settingsRepository.getWasUserOnboarded(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: 3,
                controller: _pageController,
                scrollBehavior: NoRippleBehavior(),
                itemBuilder: (context, index) => OnboardingStep(
                  icon: imagePages[index],
                  title: titlePages[index],
                  message: textPages[index],
                  scaleFactor: scaleFactor,
                ),
              ),
            ),
            SizedBox(height: 25.0 * scaleFactor),
            DotsIndicator(
              position: currentPage,
              dotsCount: 3,
              decorator: const DotsDecorator(
                activeColor: kAccentColor,
                color: kSecondaryTransparent,
                size: Size(12, 12),
                activeSize: Size(12, 12),
              ),
            ),
            const SizedBox(height: 25.0),
            FloatingActionButton(
              backgroundColor: kAccentColor,
              onPressed: () => currentPage == 2.0 ? getStarted() : nextPage(),
              child: const Icon(
                CollactionIcons.arrow_right,
                color: kSecondaryColor,
              ),
            ),
            const SizedBox(height: 25.0),
            Center(
              child: TextButton(
                onPressed: () => settingsRepository
                    .setWasUserOnboarded(wasOnboarded: true)
                    .then(context.pop),
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kAccentColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void getStarted() {
    settingsRepository
        .setWasUserOnboarded(wasOnboarded: true)
        .then((_) => context.go(AppPage.home.path));
  }
}
