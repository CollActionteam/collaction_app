// TODO: Route to this screen if first time user
import 'package:auto_route/auto_route.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import '../shared_widgets/rectangle_button.dart';
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
    final scaleFactor = MediaQuery.of(context).size.height > 600 ? 1.0 : 0.8;

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
      "Idea",
      "Crowd",
      "Action",
    ];
    final textPages = [
      "Propose a collective action and set a target number of participants",
      "People pledge to take action if the target is met before the deadline",
      "If enough people commit, we all act!",
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
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
                  (scaleFactor == 1.0 ? 0.45 : 0.50),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kAlmostTransparent,
                  borderRadius: BorderRadius.circular(25.0)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 15.0 * scaleFactor, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 25.0 * scaleFactor),
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
                                  color: kPrimaryColor400),
                            ),
                            SizedBox(height: 20.0 * scaleFactor),
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
                    SizedBox(height: 20.0 * scaleFactor),
                    DotsIndicator(
                      position: currentPage,
                      dotsCount: 3,
                      decorator: const DotsDecorator(
                          activeColor: kPrimaryColor400,
                          size: Size(12, 12),
                          activeSize: Size(12, 12)),
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      children: [
                        Expanded(
                          child: RectangleButton(
                            text: currentPage == 2.0 ? "Get started" : "Next",
                            onTap: () =>
                                currentPage == 2.0 ? getStarted() : nextPage(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => context.router.pop(),
                            child: const Text(
                              "Skip onboarding",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: kPrimaryColor300,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
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
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    _textController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  void getStarted() {
    // TODO: Replace with authentication route ( context.router.replace(AuthenticationRoute); ) - => and arrow function
    context.router.popUntilRoot();
  }
}
