import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_app/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCrowdactionRepo extends Mock implements ICrowdActionRepository {}

void main() {
  group('Testing Spotlight BLoC', () {
    final tCrowdactionRepo = MockCrowdactionRepo();
    final tCrowdactionRepo2 = MockCrowdactionRepo();
    final tSpotlightBloc = SpotlightBloc(tCrowdactionRepo);
    final tCrowdaction = CrowdAction(
      crowdactionID: 'tID',
      title: 'tTitle',
      description: 'tDescription',
      category: 'tCategory',
      location: 'tLocation',
      topParticipants: [TopParticipant(userId: 'tUser', name: 'tName')],
      commitmentOptions: [
        CommitmentOption(
          id: 'no-beef',
          label: 'tLabel',
          description: 'tDescription',
        )
      ],
      dateStart: DateTime(2022, 1, 2),
      dateEnd: DateTime(2022, 1, 31),
      dateLimitJoin: DateTime(2022, 1, 10),
      images: const Images(card: 'tCard', banner: 'tBanner'),
      participantCount: 10,
      passwordJoin: 'testPwd',
    );
    test('Testing initial state', () {
      expect(tSpotlightBloc.state, const SpotlightState.initial());
    });

    {
      when(() => tCrowdactionRepo.getSpotlightCrowdActions()).thenAnswer(
        (_) => Future.value(left(const CrowdActionFailure.serverError())),
      );

      blocTest(
        'Testing getSpotlightCrowdaction Event Failure',
        build: () => tSpotlightBloc,
        act: (SpotlightBloc bloc) {
          bloc.add(const SpotlightEvent.getSpotLightCrowdActions());
        },
        expect: () => [
          const SpotlightState.fetchingCrowdSpotLightActions(),
          const SpotlightState.spotLightCrowdActionsError(
            CrowdActionFailure.serverError(),
          )
        ],
      );
    }
    {
      when(() => tCrowdactionRepo2.getSpotlightCrowdActions()).thenAnswer(
        (_) => Future.value(right([tCrowdaction])),
      );
      blocTest(
        'Testing getSpotlightCrowdaction Event Success',
        build: () => SpotlightBloc(tCrowdactionRepo2),
        act: (SpotlightBloc bloc) {
          bloc.add(const SpotlightEvent.getSpotLightCrowdActions());
        },
        expect: () => [
          const SpotlightState.fetchingCrowdSpotLightActions(),
          SpotlightState.spotLightCrowdActions([tCrowdaction])
        ],
      );
    }
  });
}
