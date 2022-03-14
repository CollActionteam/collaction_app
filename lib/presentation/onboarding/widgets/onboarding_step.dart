import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:flutter/material.dart';

import '../../themes/constants.dart';

/// Single onboarding slate
class OnboardingStep extends StatelessWidget {
  /// Icon to display in board
  final IconData icon;

  /// Onboard title
  final String title;

  /// Onboard message
  final String message;

  /// Screen scale factor
  final double scaleFactor;

  const OnboardingStep({
    Key? key,
    required this.icon,
    required this.title,
    required this.message,
    this.scaleFactor = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Icon(
            icon,
            color: kAccentColor,
            size: icon == CollactionIcons.goal ? 40 : 180 * scaleFactor,
          ),
        ),
        SizedBox(
          height: 5.0 * scaleFactor,
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 34.0 * scaleFactor,
            color: kPrimaryColor400,
          ),
        ),
        SizedBox(height: 25.0 * scaleFactor),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * scaleFactor),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16.0 * scaleFactor,
              color: kPrimaryColor300,
            ),
          ),
        ),
      ],
    );
  }
}
