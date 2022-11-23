import 'package:collaction_app/presentation/crowdaction/crowdaction_home/widgets/share_collaction_button.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helper.dart';

void main() {
  group('ShareCollactionButton tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ShareCollactionButton());
      await tester.pumpAndSettle();

      expect(find.byType(ShareCollactionButton), findsOneWidget);
    });

    testWidgets('state', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ShareCollactionButton());
      await tester.pumpAndSettle();

      expect(find.byType(ShareCollactionButton), findsOneWidget);

      await tester.tap(find.byType(ShareCollactionButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('onFocusChange', (WidgetTester tester) async {
      final ShareCollactionButton shareCollactionButton =
          ShareCollactionButton();

      await buildAndPump(tester: tester, widget: shareCollactionButton);
      await tester.pumpAndSettle();

      final state = tester.state<ShareCollactionButtonState>(
        find.byType(ShareCollactionButton),
      );

      state.onFocusChange(true);
      state.onFocusChange(false);
    });
  });
}
