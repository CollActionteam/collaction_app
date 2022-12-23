import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/participation/participation_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/confirm_participation.dart';
import 'package:collaction_app/presentation/shared_widgets/commitments/commitment_card.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../application/participation/participation_bloc.mock.dart';
import '../../../test_utilities.dart';
import '../../router.mocks.dart';

part 'confirm_participation_test.ext.dart';

void main() {
  late StackRouter stackRouter;
  late ParticipationBloc participationBloc;

  setUpAll(() {
    stackRouter = RouteHelpers.setUpRouterStubs();
    when(() => stackRouter.pop()).thenAnswer((_) async => true);

    // Participation Bloc
    participationBloc = MockParticipationBloc();
    when(() => participationBloc.state).thenAnswer(
      (_) => ParticipationState.notParticipating(),
    );
    GetIt.I.registerSingleton<ParticipationBloc>(participationBloc);
  });

  tearDownAll(() {
    GetIt.I.unregister<ParticipationBloc>();
  });

  group('ConfirmParticipation tests:', () {
    testWidgets(
        'when not participating, render ParticipationDialog '
        'and press "Cancel" TextButton to pop context',
        (WidgetTester tester) async {
      await tester.pumpConfirmParticipation(
        stackRouter,
        participationBloc,
        tCrowdaction,
        [],
      );
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmParticipation), findsOneWidget);
      expect(find.byType(ParticipationDialog), findsOneWidget);

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      verify(() => stackRouter.pop()).called(1);
    });

    testWidgets('shows 0 commitments, with Confirm button disabled',
        (WidgetTester tester) async {
      await tester.pumpConfirmParticipation(
        stackRouter,
        participationBloc,
        tCrowdaction,
        [],
      );
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCard), findsNothing);
      expect(find.text('Your commitment'), findsOneWidget);
      expect(
        find.text(
          'You’re almost there! You’ve selected the displayed commitment to stick to through this CrowdAction. By clicking “Confirm” you will officially commit to this CrowdAction.',
        ),
        findsOneWidget,
      );

      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        false,
      );
    });

    testWidgets('shows 1 commitment, with Confirm button enabled',
        (WidgetTester tester) async {
      await tester.pumpConfirmParticipation(
        stackRouter,
        participationBloc,
        tCrowdaction,
        [tCommitmentOption],
      );
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCard), findsOneWidget);
      expect(find.text('Your commitment'), findsOneWidget);
      expect(
        find.text(
          'You’re almost there! You’ve selected the displayed commitment to stick to through this CrowdAction. By clicking “Confirm” you will officially commit to this CrowdAction.',
        ),
        findsOneWidget,
      );
      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        true,
      );
    });

    testWidgets('shows 3 commitments', (WidgetTester tester) async {
      await tester.pumpConfirmParticipation(
        stackRouter,
        participationBloc,
        tCrowdaction,
        List.filled(3, tCommitmentOption),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCard), findsNWidgets(3));
      expect(find.text('Your commitments'), findsOneWidget);
      expect(
        find.text(
          'You’re almost there! You’ve selected the displayed commitments to stick to through this CrowdAction. By clicking “Confirm” you will officially commit to this CrowdAction.',
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'on Confirm, adds toggleParticipation event to Participation Bloc',
        (WidgetTester tester) async {
      final selectedCommitments = List.filled(3, tCommitmentOption);

      await tester.pumpConfirmParticipation(
        stackRouter,
        participationBloc,
        tCrowdaction,
        selectedCommitments,
      );
      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();
      verify(
        () => participationBloc.add(
          ParticipationEvent.toggleParticipation(
            crowdActionId: tCrowdaction.id,
            commitmentOptions: selectedCommitments.map((c) => c.id).toList(),
          ),
        ),
      );
    });

    testWidgets(
        'when participating, render ParticipationSuccess '
        'and press "Got it" PillButton to pop context',
        (WidgetTester tester) async {
      when(() => participationBloc.state).thenAnswer(
        (_) => ParticipationState.participating(tParticipation),
      );

      await tester.pumpConfirmParticipation(
        stackRouter,
        participationBloc,
        tCrowdaction,
        [],
      );
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmParticipation), findsOneWidget);
      expect(find.byType(ParticipationSuccess), findsOneWidget);

      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();
      verify(() => stackRouter.pop()).called(1);
    });
  });
}
