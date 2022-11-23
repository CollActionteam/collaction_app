import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/application/participation/top_participants/top_participants_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:collaction_app/presentation/shared_widgets/crowdaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../application/participation/top_participants/top_participants_bloc.mocks.dart';
import '../../test_utilities.dart';
import '../router.mocks.dart';

part 'crowdaction_card_test.ext.dart';

void main() {
  late StackRouter stackRouter;

  late TopParticipantsBloc topParticipantsBloc;
  late CrowdActionDetailsBloc crowdActionDetailsBloc;

  const baseStaticUrl = 'https://staticurl.com/';

  setUpAll(() {
    stackRouter = RouteHelpers.setUpRouterStubs();

    // Participants Bloc
    topParticipantsBloc = MockTopParticipantsBloc();
    when(() => topParticipantsBloc.state)
        .thenAnswer((_) => TopParticipantsState.initial());

    GetIt.I.registerSingleton<TopParticipantsBloc>(topParticipantsBloc);

    // Crowdaction Details Bloc
    crowdActionDetailsBloc = MockCrowdActionDetailsBloc();
    when(() => crowdActionDetailsBloc.state)
        .thenAnswer((_) => CrowdActionDetailsState.initial());
    GetIt.I.registerSingleton<CrowdActionDetailsBloc>(crowdActionDetailsBloc);

    // dot env
    dotenv.testLoad(
      fileInput: '''
                BASE_STATIC_ENDPOINT_URL=$baseStaticUrl\t
                ''',
    );
  });

  tearDownAll(() {
    GetIt.I.unregister<TopParticipantsBloc>();
    GetIt.I.unregister<CrowdActionDetailsBloc>();
  });

  testWidgets(
      'should go to [CrowdActionDetailsPage] '
      'when the CrowdAction has no password '
      'and [CrowActionCard] is tapped', (tester) async {
    await tester.pumpCrowdactionCard(tCrowdactionNoPassword, stackRouter);

    await tester.tap(find.byType(CrowdActionCard));

    final capturedRoutes =
        verify(() => stackRouter.push(captureAny())).captured;

    expect(capturedRoutes.length, 1);
    expect(capturedRoutes.first, isA<CrowdActionDetailsRoute>());

    final route = capturedRoutes.first as CrowdActionDetailsRoute;
    expect(route.args?.crowdAction, tCrowdactionNoPassword);
    expect(route.args?.crowdActionId, null);
  });
}
