import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    accentColor: kAccentColor,
    primaryColorBrightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Rubik',
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
    buttonTheme: ButtonThemeData(
      buttonColor: kPrimaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: kInactiveColor,
      ),
      filled: true,
      fillColor: kAlmostTransparent,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide.none,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kPrimaryColor,
          width: 1.0,
        ),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kErrorColor,
          width: 1.0,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kErrorColor,
          width: 1.0,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
    ),
  );
}
