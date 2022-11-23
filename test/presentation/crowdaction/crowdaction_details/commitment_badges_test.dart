import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/commitment_badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helper.dart';

void main() {
  group('CommitmentBadges', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CommitmentBadges());
      await tester.pump();

      expect(find.byType(CommitmentBadges), findsOneWidget);
    });

    testWidgets('can render popup card', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CommitmentBadges());
      await tester.pump();

      expect(find.byType(CommitmentBadges), findsOneWidget);

      await tester.tap(find.text('My badge'));
      await tester.pumpAndSettle();

      expect(find.byType(IconButton), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentBadges), findsOneWidget);
    });
  });
}
