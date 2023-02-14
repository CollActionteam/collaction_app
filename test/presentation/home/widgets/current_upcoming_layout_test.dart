import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';
import 'package:collaction_app/presentation/home/widgets/current_upcoming_layout.dart';
import 'package:collaction_app/presentation/shared_widgets/micro_crowdaction_card.dart';
import 'package:collaction_app/presentation/shared_widgets/micro_crowdaction_card_loading.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../application/crowdaction/spotlight/spotlight_bloc.mocks.dart';
import '../../../test_utilities.dart';
import '../../../utils/crowdactions.dart';

void main() {
  final crowdActionsList = crowdActions;
  late SpotlightBloc spotlightBloc;

  setUpAll(() {
    dotenv.testLoad(fileInput: tDotEnv);
  });

  setUp(() {
    spotlightBloc = MockSpotlightBloc();
  });

  testWidgets(
      "should show loading state "
      "when loading spotlight crowdactions", (WidgetTester tester) async {
    // arrange
    when(() => spotlightBloc.state)
        .thenAnswer((_) => SpotlightState.fetchingCrowdSpotLightActions());
    await tester.pumpCurrentAndUpcomingLayout(spotlightBloc);

    // assert
    expect(find.byType(MicroCrowdActionCardLoading), findsWidgets);
    expect(find.byType(MicroCrowdActionCard), findsNothing);
  });

  testWidgets(
      "should show loading state "
      "when spotlight crowdactions list is empty", (WidgetTester tester) async {
    // arrange
    when(() => spotlightBloc.state).thenAnswer(
      (_) => SpotlightState.spotLightCrowdActions([]),
    );
    await tester.pumpCurrentAndUpcomingLayout(spotlightBloc);

    // assert
    expect(find.byType(MicroCrowdActionCardLoading), findsWidgets);
    expect(find.byType(MicroCrowdActionCard), findsNothing);
  });

  testWidgets(
      "should show [MicroCrowdActionCard] list "
      "when spotlight crowdactions are loaded", (WidgetTester tester) async {
    // arrange
    when(() => spotlightBloc.state).thenAnswer(
      (_) => SpotlightState.spotLightCrowdActions(
        crowdActionsList.map((e) => e.toDomain()).toList(),
      ),
    );
    await tester.pumpCurrentAndUpcomingLayout(spotlightBloc);

    // assert
    expect(find.byType(MicroCrowdActionCardLoading), findsNothing);
    expect(find.byType(MicroCrowdActionCard),
        findsNWidgets(crowdActionsList.length));
  });
}

extension WidgetTesterX on WidgetTester {
  Future<void> pumpCurrentAndUpcomingLayout(
    SpotlightBloc bloc, {
    bool isCurrent = true,
  }) async {
    await pumpWidget(
      MaterialApp(
        theme: lightTheme(),
        home: BlocProvider.value(
          value: bloc,
          child: Scaffold(
            body: CurrentAndUpcomingLayout(isCurrent: isCurrent),
          ),
        ),
      ),
    );
  }
}
