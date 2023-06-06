import 'dart:io';

import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:collaction_app/presentation/shared_widgets/micro_crowdaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../test_utilities.dart';
import '../router.mocks.dart';

void main() {
  late GoRouter goRouter;
  late CrowdActionDetailsBloc crowdActionDetailsBloc;

  setUpAll(() {
    goRouter = RouteHelpers.setUpRouterStubs();

    // Crowdaction Details Bloc
    crowdActionDetailsBloc = MockCrowdActionDetailsBloc();
    when(() => crowdActionDetailsBloc.state)
        .thenAnswer((_) => CrowdActionDetailsState.initial());
    GetIt.I.registerSingleton<CrowdActionDetailsBloc>(crowdActionDetailsBloc);

    // dot env
    dotenv.testLoad(fileInput: tDotEnv);

    HttpOverrides.global = null;
  });

  tearDownAll(() {
    GetIt.I.unregister<CrowdActionDetailsBloc>();
  });

  testWidgets(
      'should go to [CrowdActionDetailsPage] '
      'when the CrowdAction has no password '
      'and [MicroCrowdActionCard] is tapped', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MicroCrowdActionCard(
            tCrowdactionNoPassword,
          ),
        ),
      ).withRouterScope(goRouter),
    );

    await tester.tap(find.byType(MicroCrowdActionCard));
    await tester.pumpAndSettle();

    verify(
      () => goRouter.push(
        AppPage.crowdActionDetailsRoute(tCrowdactionNoPassword.id),
      ),
    ).called(1);
  });
}
