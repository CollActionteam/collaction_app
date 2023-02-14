part of '../themes.dart';

extension ButtonX on ThemeData {
  ThemeData themeButtons() {
    return copyWith(
      buttonTheme: ButtonThemeData(
        buttonColor: colors.primaryColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.accentColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          // foregroundColor: MaterialStateProperty.resolveWith<Color?>((states) {
          //   if (states.contains(MaterialState.disabled)) {
          //     // TODO: Return disabled button color
          //   }
          //   return colorScheme.background;
          // }),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(52),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                // TODO: Replace with theme color
                return colors.almostTransparent;
              }
              return colors.accentColor;
            },
          ),
          elevation: MaterialStateProperty.all(0),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            colors.primaryColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(52),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: colors.primaryColor!),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          ),
          backgroundColor: MaterialStateProperty.all(
            Colors.transparent,
          ),
          elevation: MaterialStateProperty.all(0),
        ),
      ),
    );
  }
}
