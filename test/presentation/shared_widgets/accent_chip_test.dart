import 'package:collaction_app/presentation/shared_widgets/accent_chip.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('AccentChip tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: AccentChip(text: 'text'));
      await tester.pumpAndSettle();

      expect(find.byType(AccentChip), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    });
  });
}
