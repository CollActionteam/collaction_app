import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
/// This class contains general static utility methods used throughout the
/// app.
class Utilities {
  /// Launches a [Route] on top of the navigation stack.
  static void launchRoute(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return screen;
        },
      ),
    );
  }
}
