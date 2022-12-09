import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('PillButton tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: PillButton(text: 'text'));
      await tester.pumpAndSettle();
      expect(find.byType(PillButton), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    });

    testWidgets('callback calls when enabled', (WidgetTester tester) async {
      bool onTapResult = false;
      await buildAndPump(
        tester: tester,
        widget: PillButton(
          text: 'text',
          onTap: () => onTapResult = true,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();
      expect(onTapResult, true);
    });

    testWidgets('callback does not call when disabled',
        (WidgetTester tester) async {
      bool onTapResult = false;
      await buildAndPump(
        tester: tester,
        widget: PillButton(
          text: 'text',
          onTap: () => onTapResult = true,
          isEnabled: false,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();
      expect(onTapResult, false);
    });

    testWidgets('loading state behaves correctly', (WidgetTester tester) async {
      bool onTapResult = false;
      await buildAndPump(
        tester: tester,
        widget: PillButton(
          text: 'text',
          onTap: () => onTapResult = true,
          isLoading: true,
        ),
      );
      await tester.pump();
      expect(find.text('text'), findsNothing);
      await tester.tap(find.byType(PillButton));
      await tester.pump();
      expect(onTapResult, false);
    });
  });
}
