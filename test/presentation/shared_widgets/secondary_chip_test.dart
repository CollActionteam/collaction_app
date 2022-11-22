import 'package:collaction_app/presentation/shared_widgets/secondary_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('SecondaryChip tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: SecondaryChip(text: 'text'));
      await tester.pumpAndSettle();

      expect(find.byType(SecondaryChip), findsOneWidget);
      expect(find.byType(Chip), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
    });
  });
}
