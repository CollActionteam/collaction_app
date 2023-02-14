import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/participation/participation_bloc.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/withdraw_participation.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../application/participation/participation_bloc.mock.dart';
import '../../../test_helper.dart';
import '../../../test_utilities.dart';
import '../../../utils/participation.fixtures.dart';
import '../../router.mocks.dart';

void main() {
  late StackRouter stackRouter;

  late ParticipationBloc participationBloc;
  bool cancelPressed = false;

  setUpAll(() {
    stackRouter = RouteHelpers.setUpRouterStubs();
    when(() => stackRouter.pop()).thenAnswer((_) async => true);

    participationBloc = MockParticipationBloc();
    when(() => participationBloc.state).thenAnswer(
      (_) => ParticipationState.participating(testParticipation),
    );
    when(
      () => participationBloc.add(
        ParticipationEvent.toggleParticipation(crowdActionId: tCrowdaction.id),
      ),
    ).thenAnswer((_) => cancelPressed = true);
  });

  group('WithdrawParticipation tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: WithdrawParticipation(
          participationBloc: participationBloc,
          crowdAction: tCrowdaction,
          isParticipating: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(WithdrawParticipation), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets("won't render when not participating",
        (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: WithdrawParticipation(
          participationBloc: participationBloc,
          crowdAction: tCrowdaction,
          isParticipating: false,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(GestureDetector), findsNothing);
    });

    testWidgets(
        'tap GestureDetector to open a modal, then cancel the participation',
        (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: WithdrawParticipation(
          participationBloc: participationBloc,
          crowdAction: tCrowdaction,
          isParticipating: true,
        ),
      );
      await tester.tap(find.byType(Text));
      await tester.pumpAndSettle();

      expect(find.byType(PillButton), findsOneWidget);

      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();
      expect(cancelPressed, true);
    });

    testWidgets('modal can be closed', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme(),
          home: Scaffold(
            body: WithdrawParticipation(
              participationBloc: participationBloc,
              crowdAction: tCrowdaction,
              isParticipating: true,
            ),
          ),
        ).withRouterScope(stackRouter),
      );
      await tester.tap(find.byType(Text));
      await tester.pumpAndSettle();

      expect(find.byType(TextButton), findsOneWidget);

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      verify(() => stackRouter.pop()).called(1);
    });

    testWidgets('post-cancel modal renders and closes on PillButton tap',
        (WidgetTester tester) async {
      when(() => participationBloc.state).thenAnswer(
        (_) => ParticipationState.notParticipating(),
      );

      await buildAndPump(
        tester: tester,
        widget: WithdrawParticipation(
          participationBloc: participationBloc,
          crowdAction: tCrowdaction,
          isParticipating: true,
        ),
      );
      await tester.tap(find.byType(Text));
      await tester.pumpAndSettle();

      expect(find.byType(PillButton), findsOneWidget);

      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();
      expect(find.byType(PillButton), findsNothing);
    });
  });
}
