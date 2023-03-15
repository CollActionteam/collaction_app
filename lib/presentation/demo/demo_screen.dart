import '../account_information/account_information_screen.dart';
import 'package:flutter/material.dart';

import '../../domain/core/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';

class DemoPage extends StatelessWidget {
  DemoPage({super.key});
  final settingsRepository = getIt<ISettingsRepository>();
  //final _pageScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccountInfoScreen(),

      // body: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 24.0),
      //     child: SingleChildScrollView(
      //       controller: _pageScrollController,
      //       child: Column(
      //         children: [
      //           const Text(
      //             'Welcome to Demo Screen!',
      //             style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34.0),
      //             textAlign: TextAlign.center,
      //           ),
      //           const SizedBox(height: 30.0),
      //           RectangleButton(
      //             text: "Reusable Components",
      //             onTap: () => context.router.push(const ComponentsDemoRoute()),
      //           ),
      //           const SizedBox(height: 10.0),
      //           RectangleButton(
      //             text: "Crowdaction Comments",
      //             onTap: () =>
      //                 context.router.push(const CrowdActionCommentsRoute()),
      //           ),
      //           const SizedBox(height: 10.0),
      //           RectangleButton(
      //             text: "Contact Form",
      //             onTap: () => context.router.push(const ContactFormRoute()),
      //           ),
      //           const SizedBox(height: 10.0),
      //           RectangleButton(
      //             text: "Onboarding",
      //             onTap: () => context.router.push(const OnboardingRoute()),
      //           ),
      //           const SizedBox(
      //             height: 15.0,
      //           ),
      //           CurrentUserStatusText(),
      //           const SizedBox(
      //             height: 15.0,
      //           ),
      //           RectangleButton(
      //             text: "Register",
      //             onTap: () => context.router.push(const AuthRoute()),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
