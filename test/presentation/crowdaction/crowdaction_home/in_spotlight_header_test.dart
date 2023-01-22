import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';
import 'package:collaction_app/application/participation/top_participants/top_participants_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_home/widgets/spotlight_crowdactions/spotlight_crowdactions.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_home/widgets/in_spotlight_header.dart';
import 'package:collaction_app/presentation/shared_widgets/content_placeholder.dart';
import 'package:collaction_app/presentation/shared_widgets/crowdaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mocktail/mocktail.dart';

import '../../../application/auth/auth_bloc.mocks.dart';
import '../../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../../application/crowdaction/crowdaction_home/spotlight_bloc.mocks.dart';
import '../../../application/participation/top_participants/top_participants_bloc.mocks.dart';
import '../../../test_utilities.dart';

part 'in_spotlight_header_test.ext.dart';

void main() {
  late SpotlightBloc spotlightBloc;
  late AuthBloc authBloc;
  late TopParticipantsBloc topParticipantsBloc;
  late CrowdActionDetailsBloc crowdActionDetailsBloc;

  setUpAll(() {
    // Spotlight Bloc
    spotlightBloc = MockSpotlightBloc();
    when(() => spotlightBloc.state).thenAnswer(
      (_) => SpotlightState.initial(),
    );
    GetIt.I.registerSingleton<SpotlightBloc>(spotlightBloc);

    // Auth Bloc
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenAnswer(
      (_) => AuthState.initial(),
    );
    GetIt.I.registerSingleton<AuthBloc>(authBloc);

    // Top Participants Bloc
    topParticipantsBloc = MockTopParticipantsBloc();
    when(() => topParticipantsBloc.state).thenAnswer(
      (_) => TopParticipantsState.initial(),
    );
    GetIt.I.registerSingleton<TopParticipantsBloc>(topParticipantsBloc);

    // CrowdAction Details Bloc
    crowdActionDetailsBloc = MockCrowdActionDetailsBloc();
    when(() => crowdActionDetailsBloc.state).thenAnswer(
      (_) => CrowdActionDetailsState.initial(),
    );
    GetIt.I.registerSingleton<CrowdActionDetailsBloc>(crowdActionDetailsBloc);

    dotenv.testLoad(fileInput: tDotEnv);
  });

  tearDownAll(() {
    GetIt.I.unregister<SpotlightBloc>();
    GetIt.I.unregister<AuthBloc>();
    GetIt.I.unregister<TopParticipantsBloc>();
    GetIt.I.unregister<CrowdActionDetailsBloc>();
  });

  group('InSpotlightHeader tests:', () {
    testWidgets('can render initial state', (WidgetTester tester) async {
      await tester.pumpInSpotLightHeader(spotlightBloc);
      await tester.pumpAndSettle();

      expect(find.byType(InSpotLightHeader), findsOneWidget);
      expect(
        find.text("${DateFormat.MMMM().format(DateTime.now())}'s CrowdActions"),
        findsOneWidget,
      );
    });

    testWidgets('can render fetchingCrowdSpotLightActions state',
        (WidgetTester tester) async {
      when(() => spotlightBloc.state).thenAnswer(
        (_) => SpotlightState.fetchingCrowdSpotLightActions(),
      );

      await tester.pumpInSpotLightHeader(spotlightBloc);
      await tester.pump();

      expect(find.byType(InSpotLightHeader), findsOneWidget);
      expect(find.byType(SpotlightEmptyHeader), findsOneWidget);
    });

    testWidgets('can render spotLightCrowdActionsError state',
        (WidgetTester tester) async {
      when(() => spotlightBloc.state).thenAnswer(
        (_) => SpotlightState.spotLightCrowdActionsError(
          CrowdActionFailure.networkRequestFailed(),
        ),
      );

      await tester.pumpInSpotLightHeader(spotlightBloc);
      await tester.pumpAndSettle();

      expect(find.byType(InSpotLightHeader), findsOneWidget);
      expect(find.byType(ContentPlaceholder), findsOneWidget);
    });

    testWidgets('can render spotLightCrowdActions state',
        (WidgetTester tester) async {
      when(() => spotlightBloc.state).thenAnswer(
        (_) => SpotlightState.spotLightCrowdActions([tCrowdaction]),
      );

      await tester.pumpInSpotLightHeader(spotlightBloc);
      await tester.pumpAndSettle();

      expect(find.byType(InSpotLightHeader), findsOneWidget);
      expect(find.byType(CrowdActionCard), findsOneWidget);
    });
  });
}
