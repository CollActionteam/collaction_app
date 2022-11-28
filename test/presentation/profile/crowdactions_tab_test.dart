import 'package:collaction_app/presentation/profile/widget/crowdactions_tab.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';
import '../../test_utilities.dart';
import 'commitments_tab_fixtures.dart';

void main() {
  group('CrowdActionsTab tests', () {
    setUp(() {
      dotenv.testLoad(fileInput: tDotEnv);
    });

    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CrowdActionsTab());
      await tester.pumpAndSettle();

      expect(find.byType(CrowdActionsTab), findsOneWidget);
    });

    testWidgets('with user', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CrowdActionsTab(user: user));
      await tester.pumpAndSettle();

      expect(find.byType(CrowdActionsTab), findsOneWidget);
    });

    testWidgets('with crowdaction', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: CrowdActionsTab(
            crowdActions: [crowdAction],
          ));
      await tester.pumpAndSettle();

      expect(find.byType(CrowdActionsTab), findsOneWidget);
    });

    testWidgets('with crowdaction and user', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: CrowdActionsTab(
            user: user,
            crowdActions: [crowdAction],
          ));
      await tester.pumpAndSettle();

      expect(find.byType(CrowdActionsTab), findsOneWidget);
    });
  });
}
