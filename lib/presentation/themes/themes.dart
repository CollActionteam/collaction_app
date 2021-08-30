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
    accentTextTheme: Theme.of(context)
        .accentTextTheme
        .copyWith(
          button: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15.0,
          ),
          caption: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 11.0,
          ),
        )
        .apply(
          fontFamily: 'Rubik',
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
    buttonTheme: const ButtonThemeData(
      buttonColor: kPrimaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: kAccentColor,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
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
      focusedBorder: UnderlineInputBorder(),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kErrorColor,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: kErrorColor,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
    ),
  );
}
