import 'package:collaction_app/presentation/core/routes/app_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../domain/core/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';
import '../shared_widgets/rectangle_button.dart';
import 'components_demo/current_user_status_text.dart';

class DemoPage extends StatelessWidget {
  DemoPage({super.key});
  final settingsRepository = getIt<ISettingsRepository>();
  final _pageScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 24.0),
          child: SingleChildScrollView(
            controller: _pageScrollController,
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
                            context.push(AppPage.componentsDemo.toPath),
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
                        onTap: () => context.push(AppPage.contactForm.toPath),
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
                        onTap: () => context.push(AppPage.onBoarding.toPath),
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
                        onTap: () => context.push(AppPage.auth.toPath),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
