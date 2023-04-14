import 'package:collaction_app/presentation/shared_widgets/commitments/commitment_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';
import 'commitment_card_fixtures.dart';

void main() {
  group('CommitmentCard tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: CommitmentCard(
          commitment: commitmentOption,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCard), findsOneWidget);
    });

    testWidgets('deactivated', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: CommitmentCard(
          commitment: commitmentOption,
          deactivated: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCard), findsOneWidget);
    });

    testWidgets('onSelected', (WidgetTester tester) async {
      int counter = 0;

      await buildAndPump(
        tester: tester,
        widget: CommitmentCard(
          onSelected: (_) => counter++,
          onDeSelected: (_) => counter--,
          active: false,
          commitment: commitmentOption,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCard), findsOneWidget);
      expect(counter, 0);

      await tester.tap(find.byType(CommitmentCard));
      expect(counter, 1);

      await tester.tap(find.byType(CommitmentCard));
      expect(counter, 2);
    });

    testWidgets('onDeselected', (WidgetTester tester) async {
      int counter = 2;

      await buildAndPump(
        tester: tester,
        widget: CommitmentCard(
          onSelected: (_) => counter++,
          onDeSelected: (_) => counter--,
          active: true,
          commitment: commitmentOption,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCard), findsOneWidget);
      expect(counter, 2);

      await tester.tap(find.byType(CommitmentCard));
      expect(counter, 1);

      await tester.tap(find.byType(CommitmentCard));
      expect(counter, 0);
    });

    testWidgets('view only', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: CommitmentCard(
          commitment: commitmentOption,
          viewOnly: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCard), findsOneWidget);
    });
  });
}
