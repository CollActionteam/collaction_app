part of '../core.dart';

extension ContextX on BuildContext {
  ThemeData themeFromPrimaryColor(Color primaryColor) {
    return Theme.of(this).copyWith(
      colorScheme: Theme.of(this).colorScheme.copyWith(
            primary: primaryColor,
          ),
    );
  }
}
