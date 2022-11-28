import 'package:collaction_app/presentation/shared_widgets/pin_input/pin_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('PinTextField tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: PinTextField(
          controller: TextEditingController(),
          focusNode: FocusNode(),
          onChanged: (_) {},
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(PinTextField), findsOneWidget);
    });

    testWidgets('request focus', (WidgetTester tester) async {
      final focusNode = FocusNode();
      await buildAndPump(
        tester: tester,
        widget: PinTextField(
          controller: TextEditingController(),
          focusNode: focusNode,
          onChanged: (_) {},
        ),
      );

      await tester.pumpAndSettle();

      expect(focusNode.hasFocus, false);
      expect(find.byType(PinTextField), findsOneWidget);

      await tester.tap(find.byType(TextFormField));
      expect(focusNode.hasFocus, true);
    });
  });
}
