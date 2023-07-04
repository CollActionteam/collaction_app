import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routes.dart';
import '../shared_widgets/pill_button.dart';
import '../themes/constants.dart';

class UnauthenticatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                onTap: () => context.push(AppPage.auth.path),
                lightBackground: true,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
