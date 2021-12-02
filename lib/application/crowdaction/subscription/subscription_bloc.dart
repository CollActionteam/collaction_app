import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'subscription_bloc.freezed.dart';
part 'subscription_event.dart';
part 'subscription_state.dart';

@injectable
class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final ICrowdActionRepository _crowdActionRepository;

  SubscriptionBloc(this._crowdActionRepository)
      : super(const SubscriptionState.initial());

  @override
  Stream<SubscriptionState> mapEventToState(SubscriptionEvent event) async* {
    yield* event.map(
      participate: _mapParticipateToState,
      withdrawParticipation: _mapWithDrawParticipationToState,
    );
  }

  Stream<SubscriptionState> _mapWithDrawParticipationToState(
      _WithdrawParticipation value) async* {
    yield const SubscriptionState.unsubscribingFromCrowdAction();

    final failureOrSuccess =
        await _crowdActionRepository.unsubscribeFromCrowdAction(value.action);

    yield failureOrSuccess.fold(
      (failure) => const SubscriptionState.unsubscribingFailed(),
      (_) => const SubscriptionState.unsubscribed(),
    );
  }

  Stream<SubscriptionState> _mapParticipateToState(_Participate value) async* {
    yield const SubscriptionState.subscribingToCrowdAction();

    final failureOrSuccess =
        await _crowdActionRepository.subscribeToCrowdAction(value.action);

    yield failureOrSuccess.fold(
      (failure) => const SubscriptionState.subscriptionFailed(),
      (_) => const SubscriptionState.subscribed(),
    );
  }
}
