import 'package:collaction_app/presentation/shared_widgets/participant_avatars.dart';
import 'package:collaction_app/application/participation/top_participants/top_participants_bloc.dart';
import 'package:collaction_app/presentation/shared_widgets/shimmers/top_participants_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helper.dart';
import '../../application/participation/top_participants/top_participants_bloc.mocks.dart';
import '../../test_utilities.dart';

void main() {
  late TopParticipantsBloc topParticipantsBloc;

  setUpAll(() {
    // Participants Bloc
    topParticipantsBloc = MockTopParticipantsBloc();
    when(() => topParticipantsBloc.state)
        .thenAnswer((_) => TopParticipantsState.fetched(tTopParticipants));

    GetIt.I.registerSingleton<TopParticipantsBloc>(topParticipantsBloc);

    // dot env
    dotenv.testLoad(fileInput: tDotEnv);
  });

  tearDownAll(() {
    GetIt.I.unregister<TopParticipantsBloc>();
  });
  group('ParticipantAvatars tests:', () {
    testWidgets('can render initial state', (WidgetTester tester) async {
      when(() => topParticipantsBloc.state)
          .thenAnswer((_) => TopParticipantsState.initial());

      await buildAndPump(
        tester: tester,
        widget: TopParticipantAvatars(
          crowdActionId: tCrowdactionNoPassword.id,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TopParticipantAvatars), findsOneWidget);
    });

    testWidgets('can render fetching state', (WidgetTester tester) async {
      when(() => topParticipantsBloc.state)
          .thenAnswer((_) => TopParticipantsState.fetching());

      await buildAndPump(
        tester: tester,
        widget: TopParticipantAvatars(
          crowdActionId: tCrowdactionNoPassword.id,
        ),
      );
      await tester.pump();

      expect(find.byType(TopParticipantsShimmer), findsOneWidget);
    });

    testWidgets('fetched 1 participants', (WidgetTester tester) async {
      when(() => topParticipantsBloc.state)
          .thenAnswer((_) => TopParticipantsState.fetched([tParticipation]));

      await buildAndPump(
        tester: tester,
        widget: TopParticipantAvatars(
          crowdActionId: tCrowdactionNoPassword.id,
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.firstWidget<SizedBox>(find.byType(SizedBox)).width, 40);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('fetched 3 participants', (WidgetTester tester) async {
      when(() => topParticipantsBloc.state).thenAnswer(
          (_) => TopParticipantsState.fetched(List.filled(3, tParticipation)));

      await buildAndPump(
        tester: tester,
        widget: TopParticipantAvatars(
          crowdActionId: tCrowdactionNoPassword.id,
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.firstWidget<SizedBox>(find.byType(SizedBox)).width, 90);
      expect(find.byType(CircleAvatar), findsNWidgets(3));
    });

    testWidgets('fetched any other number of participants',
        (WidgetTester tester) async {
      when(() => topParticipantsBloc.state).thenAnswer(
          (_) => TopParticipantsState.fetched(List.filled(10, tParticipation)));

      await buildAndPump(
        tester: tester,
        widget: TopParticipantAvatars(
          crowdActionId: tCrowdactionNoPassword.id,
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.firstWidget<SizedBox>(find.byType(SizedBox)).width, 65);
      expect(find.byType(CircleAvatar), findsNWidgets(10));
    });
  });
}
