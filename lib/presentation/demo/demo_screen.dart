import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../authentication/current_user_status_text.dart';
import '../routes/app_routes.gr.dart';

import '../shared_widgets/custom_app_bars/clean_app_bar.dart';
import '../shared_widgets/rectangle_button.dart';

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CleanAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
          child: Column(
            children: [
              const Text(
                'Welcome to Demo Screen!',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              Row(
                children: [
                  Expanded(
                    child: RectangleButton(
                      text: "Reusable Components",
                      onTap: () =>
                          context.router.push(const ComponentsDemoRoute()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: RectangleButton(
                      text: "Contact Form",
                      onTap: () =>
                          context.router.push(const ContactFormRoute()),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: RectangleButton(
                      text: "Onboarding",
                      onTap: () => context.router.push(const OnboardingRoute()),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              CurrentUserStatusText(),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: RectangleButton(
                      text: "Register",
                      onTap: () =>
                          context.router.push(const RegisterPhoneNumberRoute()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
