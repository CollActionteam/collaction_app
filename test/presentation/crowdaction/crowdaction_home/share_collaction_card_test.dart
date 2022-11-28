import 'package:collaction_app/presentation/crowdaction/crowdaction_home/widgets/share_collaction_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helper.dart';

void main() {
  group('ShareCollActionCard tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ShareCollActionCard());
      await tester.pumpAndSettle();

      expect(find.byType(ShareCollActionCard), findsOneWidget);
    });
  });
}
