// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// WidgetbookGenerator
// **************************************************************************

import 'dart:core';
import 'package:collaction_app/core/core.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:collaction_app/widgetbook/usecases/expandable_text/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(HotReload());
}

class HotReload extends StatelessWidget {
  const HotReload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appInfo: AppInfo(
        name: 'CollAction Widgetbook',
      ),
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: lightTheme(),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: darkTheme(),
        ),
      ],
      categories: [
        WidgetbookCategory(
          name: 'use cases',
          folders: [
            WidgetbookFolder(
              name: 'presentation',
              widgets: [],
              folders: [
                WidgetbookFolder(
                  name: 'shared_widgets',
                  widgets: [
                    WidgetbookComponent(
                      name: 'ExpandableText',
                      useCases: [
                        WidgetbookUseCase(
                          name: 'ExpandableText',
                          builder: (context) => expandableText(context),
                        ),
                      ],
                    ),
                  ],
                  folders: [],
                ),
              ],
            ),
          ],
          widgets: [],
        ),
      ],
    );
  }
}
