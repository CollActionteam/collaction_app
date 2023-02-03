import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/profile/widget/signup_cta.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helper.dart';
import '../../utils/user.fixtures.dart';
import '../router.mocks.dart';

void main() {
  late StackRouter stackRouter;

  setUpAll(() {
    stackRouter = RouteHelpers.setUpRouterStubs();
  });

  group('SignUpCTA tests:', () {
    testWidgets(
      'can render no user, PillButton pushes to stack router',
      (WidgetTester tester) async {
        await buildAndPump(
            tester: tester, widget: SignUpCTA().withRouterScope(stackRouter));
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

        final capturedRoutes =
            verify(() => stackRouter.push(captureAny())).captured;
        expect(capturedRoutes.length, 1);
        expect(capturedRoutes.first, isA<AuthRoute>());
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
