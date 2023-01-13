import 'package:collaction_app/application/participation/participation_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/presentation/shared_widgets/commitments/commitment_card.dart';
import 'package:collaction_app/presentation/shared_widgets/commitments/commitment_card_list.dart';
import 'package:collaction_app/presentation/shared_widgets/shimmers/commitment_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/participation/participation_bloc.mock.dart';
import '../../test_utilities.dart';

part 'commitment_card_list_test.ext.dart';

void main() {
  late ParticipationBloc participationBloc;

  setUpAll(() {
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

  group('CommitmentCardList tests:', () {
    testWidgets('can render with commitmentOptions = null',
        (WidgetTester tester) async {
      await tester.pumpCommitmentCardList(false, null, [], participationBloc);
      await tester.pump();

      expect(find.byType(CommitmentCardList), findsOneWidget);
      expect(find.byType(CommitmentCard), findsNothing);
      expect(find.byType(CommitmentCardShimmer), findsNWidgets(3));
    });

    testWidgets('can render with 0 commitmentOptions',
        (WidgetTester tester) async {
      await tester.pumpCommitmentCardList(false, [], [], participationBloc);
      await tester.pumpAndSettle();

      expect(find.byType(CommitmentCardList), findsOneWidget);
      expect(find.byType(CommitmentCard), findsNothing);
      expect(find.byType(CommitmentCardShimmer), findsNothing);
    });

    testWidgets('can render with 1 commitmentOptions',
        (WidgetTester tester) async {
      await tester.pumpCommitmentCardList(
        false,
        [tCommitmentOption],
        [],
        participationBloc,
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(CommitmentCard, skipOffstage: false),
        findsOneWidget,
      );
      expect(find.byType(CommitmentCardShimmer), findsNothing);
    });

    testWidgets('can render with 5 commitmentOptions',
        (WidgetTester tester) async {
      await tester.pumpCommitmentCardList(
        false,
        List.filled(5, tCommitmentOption),
        [],
        participationBloc,
      );
      await tester.pumpAndSettle();

      expect(
        find.byType(CommitmentCard, skipOffstage: false),
        findsNWidgets(5),
      );
    });

    testWidgets('commitments can be selected and deselected',
        (WidgetTester tester) async {
      await tester.pumpCommitmentCardList(
        false,
        [tCommitmentOption],
        [],
        participationBloc,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CommitmentCard));
      await tester.pumpAndSettle();
      expect(
        tester
            .firstWidget<CommitmentCardList>(find.byType(CommitmentCardList))
            .selectedCommitments
            .length,
        1,
      );

      await tester.tap(find.byType(CommitmentCard));
      await tester.pumpAndSettle();
      expect(
        tester
            .firstWidget<CommitmentCardList>(find.byType(CommitmentCardList))
            .selectedCommitments
            .length,
        0,
      );
    });

    testWidgets('blocking commitments', (WidgetTester tester) async {
      await tester.pumpCommitmentCardList(
        false,
        [tCommitmentOption, tBlockingCommitmentOption],
        [],
        participationBloc,
      );
      await tester.pumpAndSettle();

      // tap a commitment with a block list - expect commitment in block list to be blocked
      await tester.tap(find.byType(CommitmentCard).last);
      await tester.pumpAndSettle();
      expect(
        tester
            .firstWidget<CommitmentCard>(find.byType(CommitmentCard))
            .deactivated,
        true,
      );
    });

    testWidgets('preselected commitments', (WidgetTester tester) async {
      await tester.pumpCommitmentCardList(
        false,
        [tCommitmentOption],
        [tCommitmentOption],
        participationBloc,
      );
      await tester.pumpAndSettle();

      expect(
        tester
            .firstWidget<CommitmentCardList>(find.byType(CommitmentCardList))
            .selectedCommitments
            .length,
        1,
      );
    });

    testWidgets('commitment is over', (WidgetTester tester) async {
      await tester.pumpCommitmentCardList(
        true,
        [tCommitmentOption],
        [tCommitmentOption],
        participationBloc,
      );
      await tester.pumpAndSettle();

      expect(
        tester
            .firstWidget<CommitmentCard>(find.byType(CommitmentCard))
            .viewOnly,
        true,
      );
    });

    testWidgets('select while already participating',
        (WidgetTester tester) async {
      when(() => participationBloc.state).thenAnswer(
        (_) => ParticipationState.participating(tParticipation),
      );

      await tester.pumpCommitmentCardList(
        true,
        [tCommitmentOption],
        [],
        participationBloc,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CommitmentCard));
      await tester.pumpAndSettle();
      expect(
        tester
            .firstWidget<CommitmentCardList>(find.byType(CommitmentCardList))
            .selectedCommitments
            .length,
        0,
      );
    });

    testWidgets('deselect while already participating',
        (WidgetTester tester) async {
      when(() => participationBloc.state).thenAnswer(
        (_) => ParticipationState.participating(tParticipation),
      );

      await tester.pumpCommitmentCardList(
        true,
        [tCommitmentOption],
        [tCommitmentOption],
        participationBloc,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CommitmentCard));
      await tester.pumpAndSettle();
      expect(
        tester
            .firstWidget<CommitmentCardList>(find.byType(CommitmentCardList))
            .selectedCommitments
            .length,
        1,
      );
    });
  });
}
