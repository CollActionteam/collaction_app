import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/shared_widgets/micro_lock.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('MicroLock tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: MicroLock());
      await tester.pumpAndSettle();

      expect(find.byType(MicroLock), findsOneWidget);
      expect(find.byIcon(CollactionIcons.lock), findsOneWidget);
    });
  });
}
