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
      : super(const SubscriptionState.initial()) {
    on<SubscriptionEvent>(
      (event, emit) async {
        await event.map(
          participate: (event) => _mapParticipateToState(emit, event),
          withdrawParticipation: (event) =>
              _mapWithdrawParticipationToState(emit, event),
        );
      },
    );
  }

  FutureOr<void> _mapWithdrawParticipationToState(
    Emitter<SubscriptionState> emit,
    _WithdrawParticipation value,
  ) async {
    emit(const SubscriptionState.unsubscribingFromCrowdAction());

    final failureOrSuccess =
        await _crowdActionRepository.unsubscribeFromCrowdAction(value.action);

    emit(
      failureOrSuccess.fold(
        (failure) => const SubscriptionState.unsubscribingFailed(),
        (_) => const SubscriptionState.unsubscribed(),
      ),
    );
  }

  FutureOr<void> _mapParticipateToState(
    Emitter<SubscriptionState> emit,
    _Participate value,
  ) async {
    emit(const SubscriptionState.subscribingToCrowdAction());

    final failureOrSuccess =
        await _crowdActionRepository.subscribeToCrowdAction(
      value.action,
      value.commitments,
      value.password,
    );

    emit(
      failureOrSuccess.fold(
        (failure) => const SubscriptionState.subscriptionFailed(),
        (_) => const SubscriptionState.subscribed(),
      ),
    );
  }
}
