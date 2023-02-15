part of '../themes.dart';

extension InputX on ThemeData {
  ThemeData themeInputs() {
    return copyWith(
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        labelStyle: TextStyle(color: kTheme.inactiveColor),
        filled: true,
        fillColor: kTheme.almostTransparent,
        focusColor: kTheme.inactiveColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.zero,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kTheme.accentColor!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.zero,
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kTheme.errorColor!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.zero,
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kTheme.errorColor!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.zero,
        ),
        contentPadding: EdgeInsets.all(10.0),
      ),
    );
  }
}
