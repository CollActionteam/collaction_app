import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'constants.dart';

MarkdownStyleSheet getStylesheetFromTheme(ThemeData theme) =>
    MarkdownStyleSheet(
      p: theme.textTheme.bodyMedium?.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w300,
        height: 1.5,
      ),
      a: theme.textTheme.bodyMedium?.copyWith(
        fontSize: 17,
        fontWeight: FontWeight.w300,
        color: kAccentColor,
        height: 1.5,
      ),
    );
