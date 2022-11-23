import 'package:collaction_app/presentation/licenses/licenses_page.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('LicensesPage tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: LicensesPage());
      await tester.pumpAndSettle();

      expect(find.byType(LicensesPage), findsOneWidget);
    });
  });
}
