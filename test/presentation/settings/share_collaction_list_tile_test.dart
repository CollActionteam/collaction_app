import 'package:collaction_app/presentation/settings/widgets/share_collaction_list_tile.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('ShareCollActionListTile tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ShareCollactionListTile());
      await tester.pumpAndSettle();

      expect(find.byType(ShareCollactionListTile), findsOneWidget);
    });

    testWidgets('state', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ShareCollactionListTile());
      await tester.pumpAndSettle();

      expect(find.byType(ShareCollactionListTile), findsOneWidget);

      await tester.tap(find.byType(ShareCollactionListTile));
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });

    testWidgets('onFocusChange', (WidgetTester tester) async {
      final ShareCollactionListTile shareCollactionButton =
          ShareCollactionListTile();

      await buildAndPump(tester: tester, widget: shareCollactionButton);
      await tester.pumpAndSettle();

      final state = tester.state<ShareCollactionListTileState>(
        find.byType(ShareCollactionListTile),
      );

      state.onFocusChange(true);
      state.onFocusChange(false);
    });
  });
}
