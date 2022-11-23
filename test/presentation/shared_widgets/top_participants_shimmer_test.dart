import 'package:collaction_app/presentation/shared_widgets/shimmers/top_participants_shimmer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('TopParticipantsShimmer tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: TopParticipantsShimmer());
      await tester.pump();

      expect(find.byType(TopParticipantsShimmer), findsOneWidget);
    });
  });
}
