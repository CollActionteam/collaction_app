import 'package:collaction_app/presentation/profile/widget/badges_tab.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('BadgesTab tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: BadgesTab());
      await tester.pumpAndSettle();

      expect(find.byType(BadgesTab), findsOneWidget);
    });
  });
}
