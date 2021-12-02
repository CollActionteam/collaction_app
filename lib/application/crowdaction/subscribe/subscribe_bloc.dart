import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'subscribe_bloc.freezed.dart';
part 'subscribe_event.dart';
part 'subscribe_state.dart';

@injectable
class SubscribeBloc extends Bloc<SubscribeEvent, SubscribeState> {
  final ICrowdActionRepository _crowdActionRepository;

  SubscribeBloc(this._crowdActionRepository)
      : super(const SubscribeState.initial());

  @override
  Stream<SubscribeState> mapEventToState(SubscribeEvent event) async* {
    yield* event.map(
      participate: _mapParticipateToState,
      withDrawParticipation: _mapWithDrawParticipationToState,
    );
  }

  Stream<SubscribeState> _mapWithDrawParticipationToState(
      _WithDrawParticipation value) async* {
    yield const SubscribeState.unSubscribingToCrowdAction();

    final failureOrSuccess =
        await _crowdActionRepository.unsubscribeToCrowdAction(value.action);

    yield failureOrSuccess.fold(
      (failure) => const SubscribeState.unSubscriptionFailed(),
      (_) => const SubscribeState.unSubscriptionDone(),
    );
  }

  Stream<SubscribeState> _mapParticipateToState(_Participate value) async* {
    yield const SubscribeState.subscribingToCrowdAction();

    final failureOrSuccess =
        await _crowdActionRepository.subscribeToCrowdAction(value.action);

    yield failureOrSuccess.fold(
      (failure) => const SubscribeState.subscriptionFailed(),
      (_) => const SubscribeState.subscriptionDone(),
    );
  }
}
