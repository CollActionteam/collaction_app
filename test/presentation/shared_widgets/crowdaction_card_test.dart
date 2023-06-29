import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/application/participation/top_participants/top_participants_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:collaction_app/presentation/shared_widgets/crowdaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../application/participation/top_participants/top_participants_bloc.mocks.dart';
import '../../test_utilities.dart';
import '../router.mocks.dart';

part 'crowdaction_card_test.ext.dart';

void main() {
  late GoRouter goRouter;

  late TopParticipantsBloc topParticipantsBloc;
  late CrowdActionDetailsBloc crowdActionDetailsBloc;

  setUpAll(() {
    goRouter = RouteHelpers.setUpRouterStubs();

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
    dotenv.testLoad(fileInput: tDotEnv);
  });

  tearDownAll(() {
    GetIt.I.unregister<TopParticipantsBloc>();
    GetIt.I.unregister<CrowdActionDetailsBloc>();
  });

  testWidgets(
      'should go to [CrowdActionDetailsPage] '
      'when the CrowdAction has no password '
      'and [CrowActionCard] is tapped', (tester) async {
    await tester.pumpCrowdactionCard(tCrowdactionNoPassword, goRouter);

    await tester.tap(find.byType(CrowdActionCard));

    verify(() => goRouter.push(
        AppPage.crowdActionDetailsRoute(tCrowdactionNoPassword.id))).called(1);
  });
}
