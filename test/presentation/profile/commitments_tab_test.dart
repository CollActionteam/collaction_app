import 'package:collaction_app/presentation/profile/widget/commitments_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';
import 'commitments_tab_fixtures.dart';

void main() {
  group('CommitmentsTab tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CommitmentsTab());
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentsTab), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('with user', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CommitmentsTab(user: user));
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentsTab), findsOneWidget);
    });

    testWidgets('with crowdaction', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: CommitmentsTab(
            crowdActions: [crowdAction],
          ));
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentsTab), findsOneWidget);
    });

    testWidgets('with crowdaction and user', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: CommitmentsTab(
            user: user,
            crowdActions: [crowdAction],
          ));
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentsTab), findsOneWidget);
    });
  });
}
