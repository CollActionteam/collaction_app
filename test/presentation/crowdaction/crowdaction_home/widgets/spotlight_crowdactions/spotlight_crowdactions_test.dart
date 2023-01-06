import 'package:collaction_app/application/crowdaction/crowdaction_details/crowdaction_details_bloc.dart';
import 'package:collaction_app/application/participation/top_participants/top_participants_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/presentation/crowdaction/crowdaction_home/widgets/spotlight_crowdactions/spotlight_crowdactions.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../application/crowdaction/crowdaction_details/crowdaction_details_bloc.mocks.dart';
import '../../../../../application/participation/top_participants/top_participants_bloc.mocks.dart';
import '../../../../../test_utilities.dart';
import '../../../../../utils/crowdactions.dart';

void main() {
  late TopParticipantsBloc topParticipantsBloc;
  late CrowdActionDetailsBloc crowdActionDetailsBloc;

  setUpAll(() {
    dotenv.testLoad(fileInput: tDotEnv);

    // Top Participants Bloc
    topParticipantsBloc = MockTopParticipantsBloc();
    when(() => topParticipantsBloc.state)
        .thenAnswer((_) => TopParticipantsState.initial());
    GetIt.instance.registerSingleton<TopParticipantsBloc>(topParticipantsBloc);

    // Crowd action details bloc
    crowdActionDetailsBloc = MockCrowdActionDetailsBloc();
    when(() => crowdActionDetailsBloc.state)
        .thenAnswer((_) => CrowdActionDetailsState.initial());
    GetIt.I.registerSingleton<CrowdActionDetailsBloc>(crowdActionDetailsBloc);
  });

  tearDownAll(() {
    GetIt.instance.unregister<TopParticipantsBloc>();
    GetIt.instance.unregister<CrowdActionDetailsBloc>();
  });

  testWidgets(
      "should display loading shimmer "
      "when crowdaction list is empty", (WidgetTester tester) async {
    // arrange
    await tester.pumpSpotlightCrowdActions();
    // act

    // assert
    expect(find.byType(SpotlightEmptyHeader), findsOneWidget);
    expect(find.byType(ExpandablePageView), findsNothing);
    expect(find.byType(DotsIndicator), findsNothing);
  });

  testWidgets(
      "should display crowdactions page view "
      "when crowdaction list is not empty", (WidgetTester tester) async {
    // arrange
    await tester.pumpSpotlightCrowdActions(
      crowdActions: crowdActions.map((e) => e.toDomain()).toList(),
    );
    // act

    // assert
    expect(find.byType(SpotlightEmptyHeader), findsNothing);
    expect(find.byType(ExpandablePageView), findsOneWidget);
    expect(find.byType(DotsIndicator), findsOneWidget);
  });
}

extension WidgetTesterX on WidgetTester {
  Future<void> pumpSpotlightCrowdActions(
      {List<CrowdAction>? crowdActions}) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SpotlightCrowdActions(
            pages: crowdActions ?? [],
          ),
        ),
      ),
    );
  }
}
