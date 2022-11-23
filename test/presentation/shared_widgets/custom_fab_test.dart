import 'package:collaction_app/presentation/shared_widgets/custom_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('CustomFAB tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: CustomFAB(
            child: const Text('text'),
          ));
      await tester.pump();

      expect(find.byType(CustomFAB), findsOneWidget);
    });
  });
}
