import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:collaction_app/presentation/shared_widgets/micro_crowdaction_card.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../test_utilities.dart';
import '../router.mocks.dart';

void main() {
  late StackRouter stackRouter;
  late CrowdActionDetailsBloc crowdActionDetailsBloc;

  setUpAll(() {
    stackRouter = RouteHelpers.setUpRouterStubs();

    // Crowdaction Details Bloc
    crowdActionDetailsBloc = MockCrowdActionDetailsBloc();
    when(() => crowdActionDetailsBloc.state)
        .thenAnswer((_) => CrowdActionDetailsState.initial());
    GetIt.I.registerSingleton<CrowdActionDetailsBloc>(crowdActionDetailsBloc);

    // dot env
    dotenv.testLoad(fileInput: tDotEnv);
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
        theme: lightTheme(),
        home: Scaffold(
          body: MicroCrowdActionCard(
            tCrowdactionNoPassword,
          ),
        ),
      ).withRouterScope(stackRouter),
    );

    await tester.tap(find.byType(MicroCrowdActionCard));
    await tester.pumpAndSettle();

    final capturedRoutes =
        verify(() => stackRouter.push(captureAny())).captured;

    expect(capturedRoutes.length, 1);
    expect(capturedRoutes.first, isA<CrowdActionDetailsRoute>());

    final route = capturedRoutes.first as CrowdActionDetailsRoute;
    expect(route.args?.crowdAction, null);
    expect(route.args?.crowdActionId, tCrowdactionNoPassword.id);
  });
}
