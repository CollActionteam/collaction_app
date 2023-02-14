part of '../themes.dart';

extension InputX on ThemeData {
  ThemeData themeInputs() {
    return copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        labelStyle: TextStyle(color: colors.inactiveColor),
        filled: true,
        fillColor: colors.almostTransparent,
        focusColor:colors.inactiveColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.accentColor!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.zero,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.errorColor!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.zero,
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: colors.errorColor!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.zero,
        ),
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }
}
