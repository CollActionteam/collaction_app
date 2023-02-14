import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import '../../core/core.dart';

part 'widget_themes/button.theme.dart';
part 'widget_themes/input.theme.dart';
part 'widget_themes/scheme.theme.dart';
part 'widget_themes/text.theme.dart';

@WidgetbookTheme(name: 'Light')
ThemeData lightTheme() {
  final theme = ThemeData.light();

  return theme
      .copyWith(
        extensions: <ThemeExtension<dynamic>>[
          CollactionColors.light,
        ],
        colorScheme: theme.colorScheme.copyWith(
          background: Colors.white,
          onBackground: Colors.black,
        ),
        brightness: Brightness.light,
      )
      .themeScheme()
      .themeButtons()
      .themeInputs()
      .themeText();
}

@WidgetbookTheme(name: 'Dark')
ThemeData darkTheme() {
  final theme = ThemeData.dark();

  return theme
      .copyWith(
        extensions: <ThemeExtension<dynamic>>[
          CollactionColors.dark,
        ],
        colorScheme: theme.colorScheme.copyWith(
          background: theme.scaffoldBackgroundColor,
          onBackground: Colors.white,
        ),
      )
      .themeScheme()
      .themeButtons()
      .themeInputs()
      .themeText();
}
