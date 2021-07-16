import 'package:flutter/material.dart';

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
