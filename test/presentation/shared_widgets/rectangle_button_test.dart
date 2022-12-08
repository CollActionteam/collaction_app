import 'package:collaction_app/presentation/shared_widgets/rectangle_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('RectangleButton tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: RectangleButton(text: 'text'));
      await tester.pumpAndSettle();

      expect(find.byType(RectangleButton), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    });

    testWidgets('callback calls on tap when enabled',
        (WidgetTester tester) async {
      bool onTapResponse = false;
      await buildAndPump(
          tester: tester,
          widget: RectangleButton(
              text: 'text',
              onTap: () {
                onTapResponse = true;
              }));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RectangleButton));
      await tester.pumpAndSettle();
      expect(onTapResponse, true);
    });

    testWidgets('callback does not call on tap when disabled',
        (WidgetTester tester) async {
      bool onTapResponse = false;
      await buildAndPump(
          tester: tester,
          widget: RectangleButton(
            text: 'text',
            onTap: () {
              onTapResponse = true;
            },
            enabled: false,
          ));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RectangleButton));
      await tester.pumpAndSettle();
      expect(onTapResponse, false);
    });
  });
}
