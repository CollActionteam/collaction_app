import 'package:collaction_app/presentation/shared_widgets/centered_loading_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('CenteredLoadingIndicator tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CenteredLoadingIndicator());
      await tester.pump();

      expect(find.byType(CenteredLoadingIndicator), findsOneWidget);
    });
  });
}
