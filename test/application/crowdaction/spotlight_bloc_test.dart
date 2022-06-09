import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/crowdaction/spotlight/spotlight_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'spotlight_bloc_fixtures.dart';

void main() {
  group('Testing Spotlight BLoC', () {
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
