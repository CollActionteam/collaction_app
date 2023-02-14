part of '../themes.dart';

extension TextX on ThemeData {
  ThemeData themeText() {
    return copyWith(
      textTheme: textTheme.apply(
          fontFamily: 'Rubik',
          bodyColor: onBackground,
          displayColor: onBackground,
        ),
     );
  }
}
