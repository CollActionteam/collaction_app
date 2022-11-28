import 'package:collaction_app/presentation/auth/widgets/legal_notice.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('LegalNotice tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: LegalNotice());
      await tester.pump();

      expect(find.byType(LegalNotice), findsOneWidget);
    });
  });
}
