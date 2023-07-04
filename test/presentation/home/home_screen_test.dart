import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_app/presentation/home/home_screen.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/auth/auth_bloc.mocks.dart';
import '../../test_helper.dart';
import '../../test_utilities.dart';

void main() {
  late final AppRouter appRouter;
  late final MockSettingsRepository settingsRepository;
  late final MockCrowdActionRepository crowdActionRepository;
  late SpotlightBloc spotlightBloc;
  late AuthBloc authBloc;

  setUpAll(() {
    settingsRepository = MockSettingsRepository();
    crowdActionRepository = MockCrowdActionRepository();
    spotlightBloc = SpotlightBloc(crowdActionRepository);
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenAnswer((_) => AuthState.initial());

    appRouter = AppRouter(authBloc: authBloc, settingsRepo: settingsRepository);

    GetIt.I.registerSingleton<SpotlightBloc>(spotlightBloc);
    GetIt.I.registerSingleton<ISettingsRepository>(settingsRepository);

    when(() => crowdActionRepository.getSpotlightCrowdActions()).thenAnswer(
        (invocation) => Future.value(left(CrowdActionFailure.serverError())));
  });

  tearDownAll(() {
    GetIt.I.unregister<SpotlightBloc>();
    GetIt.I.unregister<ISettingsRepository>();
  });

  tearDown(() {
    GetIt.I.unregister<SpotlightBloc>();
    spotlightBloc = SpotlightBloc(crowdActionRepository);
    GetIt.I.registerSingleton<SpotlightBloc>(spotlightBloc);
  });

  testWidgets('can render', (tester) async {
    when(() => settingsRepository.getWasUserOnboarded())
        .thenAnswer((_) => Future.value(true));

    await buildAndPump(
      tester: tester,
      widget: MaterialApp.router(
        color: Colors.white,
        title: 'CollAction',
        routerConfig: appRouter.router,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });
}
