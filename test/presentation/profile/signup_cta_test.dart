import 'package:collaction_app/presentation/profile/widget/signup_cta.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helper.dart';
import '../../utils/user.fixtures.dart';
import '../router.mocks.dart';

void main() {
  late GoRouter goRouter;

  setUpAll(() {
    goRouter = RouteHelpers.setUpRouterStubs();
  });

  group('SignUpCTA tests:', () {
    testWidgets(
      'can render no user, PillButton pushes to stack router',
      (WidgetTester tester) async {
        await buildAndPump(
            tester: tester, widget: SignUpCTA().withRouterScope(goRouter));
        await tester.pumpAndSettle();

        expect(
            find.text('Become part of the CollAction crowd'), findsOneWidget);
        expect(
          find.text(
              'Create an account to participate in \nCrowdActions and make waves with other \nlikeminded people!'),
          findsOneWidget,
        );
        expect(find.byType(PillButton), findsOneWidget);

        await tester.tap(find.byType(PillButton));
        await tester.pumpAndSettle();

        verify(() => goRouter.push(AppPage.auth.path)).called(1);
      },
    );

    testWidgets('can render with user, no title', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: SignUpCTA(user: testUser));
      await tester.pumpAndSettle();

      expect(
          find.text('Unique content based on your activity'), findsOneWidget);
    });

    testWidgets('can render with user and title', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: SignUpCTA(title: 'Test Title', user: testUser),
      );
      await tester.pumpAndSettle();

      expect(find.text('Test Title'), findsOneWidget);
    });
  });
}
