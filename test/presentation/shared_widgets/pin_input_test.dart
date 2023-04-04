import 'package:collaction_app/presentation/shared_widgets/pin_input/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  String submitOutput = '';
  group('PinInput tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: PinInput(submit: (str) => submitOutput = str),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PinInput), findsOneWidget);
    });

    testWidgets('disallows non-numeric characters',
        (WidgetTester tester) async {
      submitOutput = '';
      await buildAndPump(
        tester: tester,
        widget: PinInput(submit: (str) => submitOutput = str),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), 'a!D&6');
      expect(find.text('a!D&6'), findsNothing);
      expect(find.text('6'), findsOneWidget);
    });

    testWidgets(
        'submits when a 6-length pin'
        'is inputted to a TextFormField'
        'with max length of 6', (WidgetTester tester) async {
      submitOutput = '';
      await buildAndPump(
        tester: tester,
        widget: PinInput(submit: (str) => submitOutput = str),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), '12345');
      expect(submitOutput, '');
      await tester.enterText(find.byType(TextFormField), '123456');
      expect(submitOutput, '123456');
    });

    testWidgets('max pin length of 4', (WidgetTester tester) async {
      submitOutput = '';
      await buildAndPump(
        tester: tester,
        widget: PinInput(
          submit: (str) => submitOutput = str,
          pinLength: 4,
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), '1234');
      expect(submitOutput, '1234');
    });
  });
}
