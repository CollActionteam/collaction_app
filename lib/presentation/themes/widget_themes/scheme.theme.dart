part of '../themes.dart';

extension SchemeX on ThemeData {
  ThemeData themeScheme() {
    return copyWith(
      primaryColor: kTheme.primaryColor,
      colorScheme: colorScheme.copyWith(
        secondary: kTheme.accentColor,
        primary: kTheme.primaryColor,
        error: kTheme.errorColor,
      ),
    );
  }
}
