import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/participation_count_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../../test_helper.dart';
import '../../../test_utilities.dart';

void main() {
  late CrowdActionDetailsBloc crowdActionDetailsBloc;

  setUpAll(() {
    crowdActionDetailsBloc = MockCrowdActionDetailsBloc();
    when(() => crowdActionDetailsBloc.state).thenAnswer(
      (_) => CrowdActionDetailsState.initial(),
    );
    GetIt.I.registerSingleton<CrowdActionDetailsBloc>(crowdActionDetailsBloc);
  });

  tearDownAll(() {
    GetIt.I.unregister<CrowdActionDetailsBloc>();
  });

  group('ParticipationCountText tests:', () {
    testWidgets('can render with null crowdAction',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<CrowdActionDetailsBloc>(
          create: (_) => crowdActionDetailsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ParticipationCountText(
                crowdAction: null,
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ParticipationCountText), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('can render with tCrowdaction', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: ParticipationCountText(crowdAction: tCrowdaction),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ParticipationCountText), findsOneWidget);
    });

    testWidgets('can render with 0 participants', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: ParticipationCountText(
          crowdAction: TestUtilities.crowdActionWithNParticipants(0),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Join 0 person participating'), findsOneWidget);
    });

    testWidgets('can render with 1 participants', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: ParticipationCountText(
          crowdAction: TestUtilities.crowdActionWithNParticipants(1),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Join 1 person participating'), findsOneWidget);
    });

    testWidgets('can render with 10 participants', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: ParticipationCountText(
          crowdAction: TestUtilities.crowdActionWithNParticipants(10),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Join 10 people participating'), findsOneWidget);
    });

    testWidgets('correct text when ended', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: ParticipationCountText(
          crowdAction: TestUtilities.crowdActionWithNParticipants(10),
          isEnded: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('10 people participated'), findsOneWidget);
    });

    testWidgets('loadInProgress state renders correctly',
        (WidgetTester tester) async {
      when(() => crowdActionDetailsBloc.state).thenAnswer(
        (_) => CrowdActionDetailsState.loadInProgress(),
      );
      await buildAndPump(
        tester: tester,
        widget: ParticipationCountText(
          crowdAction: TestUtilities.crowdActionWithNParticipants(10),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Join 10 people participating'), findsOneWidget);
    });

    testWidgets('loadInProgress state renders correctly with null crowdaction',
        (WidgetTester tester) async {
      when(() => crowdActionDetailsBloc.state).thenAnswer(
        (_) => CrowdActionDetailsState.loadInProgress(),
      );
      await tester.pumpWidget(
        BlocProvider<CrowdActionDetailsBloc>(
          create: (_) => crowdActionDetailsBloc,
          child: MaterialApp(
            home: Scaffold(
              body: ParticipationCountText(
                crowdAction: null,
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Text), findsNothing);
    });

    testWidgets('loadSuccess state renders correctly',
        (WidgetTester tester) async {
      when(() => crowdActionDetailsBloc.state).thenAnswer(
        (_) => CrowdActionDetailsState.loadSuccess(
            TestUtilities.crowdActionWithNParticipants(10)),
      );
      await buildAndPump(
        tester: tester,
        widget: ParticipationCountText(
          crowdAction: TestUtilities.crowdActionWithNParticipants(10),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Join 10 people participating'), findsOneWidget);
    });

    testWidgets('loadFailure state renders correctly',
        (WidgetTester tester) async {
      when(() => crowdActionDetailsBloc.state).thenAnswer(
        (_) => CrowdActionDetailsState.loadFailure(
            CrowdActionFailure.networkRequestFailed()),
      );
      await buildAndPump(
        tester: tester,
        widget: ParticipationCountText(
          crowdAction: TestUtilities.crowdActionWithNParticipants(10),
        ),
      );
      await tester.pump();

      expect(find.text('Join 10 people participating'), findsNothing);
    });
  });
}
