// TODO: Route to this screen if first time user
import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../core/collaction_icons.dart';
import '../themes/constants.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _imageController = PageController();
  final PageController _textController = PageController();
  double currentPage = 0;

  final settingsRepository = getIt<ISettingsRepository>();

  @override
  void initState() {
    super.initState();
    _imageController.addListener(() {
      if (_imageController.page != currentPage) {
        setState(() {
          currentPage = _imageController.page!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).size.height > 700 ? 1.0 : 0.8;
    final imagePages = [
      Image.asset(
        'assets/images/onboarding_one.png',
        scale: scaleFactor != 1.0 ? scaleFactor * 1.5 : scaleFactor,
      ),
      Image.asset(
        'assets/images/onboarding_two.png',
        scale: scaleFactor != 1.0 ? scaleFactor * 1.5 : scaleFactor,
      ),
      Image.asset(
        'assets/images/onboarding_three.png',
        scale: scaleFactor != 1.0 ? scaleFactor * 1.5 : scaleFactor,
      ),
    ];
    final titlePages = [
      "Goal",
      "Crowd",
      "Action",
    ];
    final textPages = [
      "Choose a challenge to reach your monthly sustainability goal",
      "Notice how much impact you can make if you join forces with likeminded people",
      "Commit to the goal and make the change",
    ];

    return WillPopScope(
      // Prevent closing the tutorial before it was completed
      onWillPop: () async => settingsRepository.getWasUserOnboarded(),
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      controller: _imageController,
                      itemBuilder: (context, index) => imagePages[index],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height *
                  (scaleFactor == 1.0 ? 0.45 : 0.46),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kAlmostTransparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5.0 * scaleFactor,
                    horizontal: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 100.0 * (scaleFactor + 0.1),
                        width: MediaQuery.of(context).size.width - 50,
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          controller: _textController,
                          itemBuilder: (context, index) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                titlePages[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 34.0 * scaleFactor,
                                  color: kPrimaryColor400,
                                ),
                              ),
                              SizedBox(height: 25.0 * scaleFactor),
                              Text(
                                textPages[index],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16.0 * scaleFactor,
                                  color: kPrimaryColor300,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 25.0 * scaleFactor),
                      DotsIndicator(
                        position: currentPage,
                        dotsCount: 3,
                        decorator: const DotsDecorator(
                          activeColor: kPrimaryColor400,
                          size: Size(12, 12),
                          activeSize: Size(12, 12),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Material(
                        elevation: 4,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: kAccentColor,
                          radius: 30,
                          child: IconButton(
                            onPressed: () =>
                                currentPage == 2.0 ? getStarted() : nextPage(),
                            icon: const Icon(
                              CollactionIcons.arrow_right,
                              color: kSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => settingsRepository
                                  .setWasUserOnboarded(wasOnboarded: true)
                                  .then((_) => context.router.pop()),
                              child: const Text(
                                "Skip",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: kAccentColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void nextPage() {
    _imageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    _textController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
  }

  void getStarted() {
    // TODO: Replace with authentication route ( context.router.replace(AuthenticationRoute); ) - => and arrow function
    settingsRepository.setWasUserOnboarded(wasOnboarded: true).then(
          (_) => context.router.popUntilRoot(),
        );
  }
}
