import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_participants/crowdaction_participants_bloc.dart';
import 'package:collaction_app/application/participation/top_participants/top_participants_bloc.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/participants.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/participation_count_text.dart';
import 'package:collaction_app/presentation/shared_widgets/participant_avatars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../../application/crowdaction/crowdaction_participants/crowdaction_participants_bloc.mocks.dart';
import '../../../application/participation/top_participants/top_participants_bloc.mocks.dart';
import '../../../test_helper.dart';
import '../../../test_utilities.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeMaterialPageRoute extends Fake implements MaterialPageRoute {}

void main() {
  late CrowdActionDetailsBloc crowdActionDetailsBloc;
  late TopParticipantsBloc topParticipantsBloc;
  late CrowdActionParticipantsBloc crowdActionParticipantsBloc;

  setUpAll(() {
    // CrowdAction Details Bloc
    crowdActionDetailsBloc = MockCrowdActionDetailsBloc();
    when(() => crowdActionDetailsBloc.state).thenAnswer(
      (invocation) => CrowdActionDetailsState.initial(),
    );
    GetIt.I.registerSingleton<CrowdActionDetailsBloc>(crowdActionDetailsBloc);

    // CrowdAction Details Bloc
    topParticipantsBloc = MockTopParticipantsBloc();
    when(() => topParticipantsBloc.state).thenAnswer(
      (invocation) => TopParticipantsState.initial(),
    );
    GetIt.I.registerSingleton<TopParticipantsBloc>(topParticipantsBloc);

    // CrowdAction Details Bloc
    crowdActionParticipantsBloc = MockCrowdActionParticipantsBloc();
    when(() => crowdActionParticipantsBloc.state).thenAnswer(
      (invocation) => CrowdActionParticipantsState.initial(),
    );
    GetIt.I.registerSingleton<CrowdActionParticipantsBloc>(
      crowdActionParticipantsBloc,
    );

    registerFallbackValue(FakeMaterialPageRoute());
  });
  group('Participants test:', () {
    testWidgets('can render with null crowdaction',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<CrowdActionDetailsBloc>(
          create: (_) => crowdActionDetailsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: Participants(
                crowdAction: null,
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Participants), findsOneWidget);
      expect(find.byType(TopParticipantAvatars), findsNothing);
    });

    testWidgets('can render with 0 participants', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: Participants(
          crowdAction: TestUtilities.crowdActionWithNParticipants(0),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TopParticipantAvatars), findsNothing);
    });

    testWidgets('can render with >0 participants', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: Participants(
          crowdAction: tCrowdaction,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TopParticipantAvatars), findsOneWidget);
    });

    testWidgets('onTap redirects to CrowdActionParticipantsPage',
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Participants(
              crowdAction: tCrowdaction,
            ),
          ),
          navigatorObservers: [mockObserver],
        ),
      );
      verify(() => mockObserver.didPush(any(), null));
      await tester.tap(find.byType(ParticipationCountText));
      await tester.pump();
      verify(() => mockObserver.didPush(any(), any()));
    });
  });
}
