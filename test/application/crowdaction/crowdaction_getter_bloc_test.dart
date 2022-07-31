import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/crowdaction/crowdaction_getter/crowdaction_getter_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_utilities.dart';
import 'spotlight_bloc_fixtures.dart';

void main() {
  final tCAList = [tCrowdaction, tCrowdaction.copyWith(id: 'id2')];
  group('Testing Crowdaction Getter BLoC for defined amount', () {
    final caGetter = CrowdActionGetterBloc(tCrowdactionRepo);
    test('Testing initial state', () {
      expect(
        caGetter.state,
        const CrowdActionGetterState.initial(),
      );
    });

    {
      when(() => tCrowdactionRepo.getCrowdActions(amount: 4)).thenAnswer(
        (_) =>
            Future.value(left(const CrowdActionFailure.networkRequestFailed())),
      );
      when(() => tCrowdactionRepo.getCrowdActions(amount: 5)).thenAnswer(
        (_) => Future.error('error'),
      );
      blocTest(
        'Testing getMore event error and failure',
        build: () => CrowdActionGetterBloc(tCrowdactionRepo),
        act: (CrowdActionGetterBloc bloc) {
          bloc.add(
            const CrowdActionGetterEvent.getMore(4),
          );
          bloc.add(
            const CrowdActionGetterEvent.getMore(5),
          );
        },
        expect: () => [
          const CrowdActionGetterState.fetchingCrowdActions(),
          const CrowdActionGetterState.noCrowdActions(),
          const CrowdActionGetterState.fetchingCrowdActions(),
          const CrowdActionGetterState.noCrowdActions(),
        ],
      );
    }
    {
      when(() => tCrowdactionRepo.getCrowdActions(amount: 2)).thenAnswer(
        (_) => Future.value(right(tCAList)),
      );

      blocTest(
        'Testing getMore event success',
        build: () => CrowdActionGetterBloc(tCrowdactionRepo),
        act: (CrowdActionGetterBloc bloc) {
          bloc.add(
            const CrowdActionGetterEvent.getMore(2),
          );
        },
        expect: () => [
          const CrowdActionGetterState.fetchingCrowdActions(),
          CrowdActionGetterState.fetched(tCAList)
        ],
      );
    }
    {
      final tCrowdActionRepo2 = MockCrowdActionRepository();

      when(() => tCrowdActionRepo2.getCrowdActions()).thenAnswer(
        (_) => Future.value(
          right(tCAList),
        ),
      );
      blocTest(
        'Testing getMore event when amount is not passed',
        build: () => CrowdActionGetterBloc(tCrowdActionRepo2),
        act: (CrowdActionGetterBloc bloc) {
          bloc.add(const CrowdActionGetterEvent.getMore(null));
        },
        expect: () => [
          const CrowdActionGetterState.fetchingCrowdActions(),
          CrowdActionGetterState.fetched(tCAList)
        ],
      );
    }
  });
}
