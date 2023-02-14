part of '../themes.dart';

extension SchemeX on ThemeData {
  ThemeData themeScheme() {
    return copyWith(
      primaryColor: colors.primaryColor,
      colorScheme: colorScheme.copyWith(
        secondary: colors.accentColor,
        primary: colors.primaryColor,
        error: colors.errorColor,
      ),
    );
  }
}
