part of '../core.dart';

extension ThemeBuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  // Primary Color
  Color get primary => theme.primary;

  // Secondary/Accent Color
  Color get secondary => theme.colorScheme.secondary;

  // Formerly Secondary Color
  Color get tertiary => theme.colorScheme.secondaryContainer;

  // Background Color
  Color get background => theme.colorScheme.background;

  // Scaffold color
  Color get scaffoldColor => theme.scaffoldBackgroundColor;

  // Foreground color
  Color get onBackground => theme.onBackground;

  // If brightness dark
  bool get isDark => theme.brightness == Brightness.dark;

  CollactionColors get colors => theme.colors;
}

extension ThemeX on ThemeData {
  CollactionColors get colors => extension<CollactionColors>()!;

  // Primary Color
  Color get primary => colorScheme.primary;

  // Foreground color
  Color get onBackground => colorScheme.onBackground;

  // Scaffold color
  Color get scaffoldColor => scaffoldBackgroundColor;
}
