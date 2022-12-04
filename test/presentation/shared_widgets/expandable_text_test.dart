import 'package:collaction_app/presentation/shared_widgets/expandable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:collaction_app/presentation/themes/constants.dart';

import '../../test_helper.dart';

void main() {
  group('AccentActionChip test:', () {
    final String text = 'this is a sample text. ';
    final int trimLines = 3;
    final Color clickableTextColor = kAccentColor;
    final String readMoreText = 'more';
    final String readLessText = 'less';
    final TextStyle style = const TextStyle(color: Colors.black);

    testWidgets('renders correctly when text is short',
        (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: ExpandableText(
            text,
            trimLines: trimLines,
            clickableTextColor: clickableTextColor,
            readMoreText: readMoreText,
            readLessText: readLessText,
            style: style,
          ));
      await tester.pumpAndSettle();

      expect(find.byType(ExpandableText), findsOneWidget);
      expect(find.byType(RichText), findsOneWidget);
      var textWidget = tester.firstWidget<RichText>(find.byType(RichText));
      expect(textWidget.text.toPlainText(), contains(text));
      expect(textWidget.text.toPlainText().length, equals(text.length));
    });

    testWidgets('renders correctly when text is long',
        (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: ExpandableText(
            text + '$text' * 10,
            trimLines: trimLines,
            clickableTextColor: clickableTextColor,
            readMoreText: readMoreText,
            readLessText: readLessText,
            style: style,
          ));
      await tester.pumpAndSettle();

      expect(find.byType(ExpandableText), findsOneWidget);
      expect(find.byType(RichText), findsOneWidget);
      var textWidget = tester.firstWidget<RichText>(find.byType(RichText));
      expect(textWidget.text.toPlainText(), contains(readMoreText));
      expect(textWidget.text.toPlainText().length,
          equals(trimLines * 30 + readMoreText.length + 4));
    });

    testWidgets('expands and minimizes correctly', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: ExpandableText(
            text + '$text' * 10,
            trimLines: trimLines,
            clickableTextColor: clickableTextColor,
            readMoreText: readMoreText,
            readLessText: readLessText,
            style: style,
          ));
      await tester.pumpAndSettle();

      fireOnTap(find.byType(RichText), readMoreText);
      await tester.pumpAndSettle();
      var textWidget = tester.firstWidget<RichText>(find.byType(RichText));
      expect(textWidget.text.toPlainText(), contains(readLessText));
      expect(textWidget.text.toPlainText().length, greaterThan(trimLines * 30));

      fireOnTap(find.byType(RichText), readLessText);
      await tester.pumpAndSettle();
      textWidget = tester.firstWidget<RichText>(find.byType(RichText));
      expect(textWidget.text.toPlainText(), contains(readMoreText));
      expect(textWidget.text.toPlainText().length,
          equals(trimLines * 30 + readMoreText.length + 4));
    });
  });
}

void fireOnTap(Finder finder, String text) {
  final Element element = finder.evaluate().single;
  final RenderParagraph paragraph = element.renderObject as RenderParagraph;
  paragraph.text.visitChildren((dynamic span) {
    if (span.text != text) return true;
    (span.recognizer as TapGestureRecognizer).onTap!();
    return false;
  });
}
