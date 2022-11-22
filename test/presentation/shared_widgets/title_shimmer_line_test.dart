import 'package:collaction_app/presentation/shared_widgets/shimmers/title_shimmer_line.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('TitleShimmerLine tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: TitleShimmerLine(width: 10));
      await tester.pumpAndSettle();
    });
  });
}
