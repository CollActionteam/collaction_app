import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/presentation/home/widgets/password_modal.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../domain/core/i_settings_repository.mocks.dart';
import '../../../test_helper.dart';
import '../../../test_utilities.dart';
import '../../router.mocks.dart';

void main() {
  late GoRouter goRouter;
  late ISettingsRepository iSettingsRepository;

  setUpAll(() {
    goRouter = RouteHelpers.setUpRouterStubs();

    iSettingsRepository = SettingsRepositoryMock();
    when(
      () => iSettingsRepository.addCrowdActionAccess(
          crowdActionId: tCrowdaction.id),
    ).thenAnswer((_) async {});
    when(
      () => iSettingsRepository.getCrowdActionAccessList(),
    ).thenAnswer((_) async => []);
    GetIt.I.registerSingleton<ISettingsRepository>(iSettingsRepository);
  });

  group('PasswordModal test:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: PasswordModal(crowdAction: tCrowdaction),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PasswordModal), findsOneWidget);
      expect(find.text('Enter password'), findsOneWidget);
      expect(
          find.text(
              'This crowdaction is private. Please enter the password to see it.'),
          findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets(
      'button enabled after text input',
      (WidgetTester tester) async {
        await buildAndPump(
          tester: tester,
          widget: PasswordModal(crowdAction: tCrowdaction),
        );
        await tester.pumpAndSettle();

        expect(
          tester
              .widget<CircleAvatar>(find.byType(CircleAvatar))
              .backgroundColor,
          kDisabledButtonColor,
        );

        await tester.enterText(find.byType(TextField), 't');
        await tester.pumpAndSettle();

        expect(
          tester
              .widget<CircleAvatar>(find.byType(CircleAvatar))
              .backgroundColor,
          kAccentColor,
        );
      },
    );

    testWidgets(
      'incorrect password causes shows error text',
      (WidgetTester tester) async {
        await buildAndPump(
          tester: tester,
          widget: PasswordModal(crowdAction: tCrowdaction),
        );
        await tester.pumpAndSettle();

        expect(find.text('Invalid password'), findsNothing);

        await tester.enterText(find.byType(TextField), 'tBadPassword');
        await tester.pumpAndSettle();
        await tester.tap(find.descendant(
          of: find.byType(CircleAvatar),
          matching: find.byType(IconButton),
        ));
        await tester.pumpAndSettle();

        expect(find.text('Invalid password'), findsOneWidget);
      },
    );

    // TODO: Fix test
    // testWidgets(
    //   'correct password calls router.popAndPush, redirects to CrowdActionDetailsRoute',
    //   (WidgetTester tester) async {
    //     await buildAndPump(
    //       tester: tester,
    //       widget: PasswordModal(crowdAction: tCrowdaction)
    //           .withRouterScope(goRouter),
    //     );
    //     await tester.pumpAndSettle();

    //     await tester.enterText(find.byType(TextField), 'testPwd');
    //     await tester.testTextInput.receiveAction(TextInputAction.done);
    //     await tester.pumpAndSettle();

    //     verify(
    //       () => iSettingsRepository.addCrowdActionAccess(
    //           crowdActionId: tCrowdaction.id),
    //     ).called(1);

    //     final capturedRoutes =
    //         verify(() => goRouter.popAndPush(captureAny())).captured;
    //     expect(capturedRoutes.length, 1);
    //     expect(capturedRoutes.first, isA<CrowdActionDetailsRoute>());

    //     final route = capturedRoutes.first as CrowdActionDetailsRoute;
    //     expect(route.args?.crowdAction, tCrowdaction);
    //     expect(route.args?.crowdActionId, null);
    //   },
    // );

    testWidgets(
      'showPasswordModal works when unverified',
      (WidgetTester tester) async {
        await buildAndPump(
          tester: tester,
          widget: MaterialApp(
            home: Scaffold(
              body: Container(),
            ),
          ),
        );
        PasswordModal.show(
            tester.element(find.byType(Container)), tCrowdaction);
        await tester.pumpAndSettle();

        expect(find.byType(PasswordModal), findsOneWidget);
      },
    );

    testWidgets(
      'showPasswordModal works when verified',
      (WidgetTester tester) async {
        when(
          () => iSettingsRepository.getCrowdActionAccessList(),
        ).thenAnswer((_) async => [tCrowdaction.id]);

        await buildAndPump(
          tester: tester,
          widget: MaterialApp(
            home: Scaffold(
              body: Container(),
            ),
          ).withRouterScope(goRouter),
        );

        PasswordModal.show(
          tester.element(find.byType(Container)),
          tCrowdaction,
        );

        await tester.pumpAndSettle();

        verify(
          () => goRouter.push(
            AppPage.crowdActionDetailsRoute(tCrowdaction.id),
          ),
        ).called(1);
      },
    );
  });
}
