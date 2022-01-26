import 'package:flutter/material.dart';

import '../themes/constants.dart';

/// Single onboarding slate
class OnBoard extends StatelessWidget {
  /// Image asset to display in board
  final String image;

  /// Onboard title
  final String title;

  /// Onboard message
  final String message;

  /// Screen scale factor
  final double scaleFactor;

  const OnBoard({
    Key? key,
    required this.image,
    required this.title,
    required this.message,
    this.scaleFactor = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(image),
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
