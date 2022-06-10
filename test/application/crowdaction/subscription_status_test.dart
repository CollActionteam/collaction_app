import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/crowdaction/subscription_status/subscription_status_bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_status.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_utilities.dart';
import 'subscription_status_fixtures.dart';

void main() {
  group('Testing Subscription status BLoC', () {
    test('Testing initial state', () {
      final subsStatusBloc = SubscriptionStatusBloc(mockCARepo);
      expect(subsStatusBloc.state, const SubscriptionStatusState.initial());
    });

    {
      when(() => mockCARepo1.checkCrowdActionSubscriptionStatus(tCrowdaction))
          .thenAnswer(
        (_) => Future.value(
          left(const CrowdActionFailure.networkRequestFailed()),
        ),
      );
      blocTest(
        'Testing check participation event failure',
        build: () => SubscriptionStatusBloc(mockCARepo1),
        act: (SubscriptionStatusBloc bloc) => bloc.add(
          SubscriptionStatusEvent.checkParticipationStatus(tCrowdaction),
        ),
        expect: () => [
          const SubscriptionStatusState.checkingSubscriptionStatus(),
          const SubscriptionStatusState.checkingSubscriptionStatusFailed(),
        ],
      );
    }
    {
      when(() => mockCARepo.checkCrowdActionSubscriptionStatus(tCrowdaction))
          .thenAnswer(
        (_) => Future.value(
          right(const CrowdActionStatus.subscribed(['tCommitment'])),
        ),
      );
      blocTest(
        'Testing check participation event success and subscribed',
        build: () => SubscriptionStatusBloc(mockCARepo),
        act: (SubscriptionStatusBloc bloc) => bloc.add(
          SubscriptionStatusEvent.checkParticipationStatus(tCrowdaction),
        ),
        expect: () => [
          const SubscriptionStatusState.checkingSubscriptionStatus(),
          const SubscriptionStatusState.subscriptionStatus(
            CrowdActionStatus.subscribed(['tCommitment']),
          ),
        ],
      );
    }
    {
      when(() => mockCARepo2.checkCrowdActionSubscriptionStatus(tCrowdaction))
          .thenAnswer(
        (_) => Future.value(
          right(const CrowdActionStatus.notSubscribed()),
        ),
      );
      blocTest(
        'Testing check participation event success and unsubscribed',
        build: () => SubscriptionStatusBloc(mockCARepo2),
        act: (SubscriptionStatusBloc bloc) {
          bloc.add(
            SubscriptionStatusEvent.checkParticipationStatus(tCrowdaction),
          );
        },
        expect: () => [
          const SubscriptionStatusState.checkingSubscriptionStatus(),
          const SubscriptionStatusState.subscriptionStatus(
            CrowdActionStatus.notSubscribed(),
          ),
        ],
      );
    }
  });
}
