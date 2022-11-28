import 'package:collaction_app/presentation/shared_widgets/shimmers/commitment_card_shimmer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('CommitmentCardShimmer tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CommitmentCardShimmer());
      await tester.pump();

      expect(find.byType(CommitmentCardShimmer), findsOneWidget);
    });
  });
}
