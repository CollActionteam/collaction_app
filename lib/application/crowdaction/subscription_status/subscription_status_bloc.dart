import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/crowdaction/crowdaction.dart';
import '../../../../domain/crowdaction/crowdaction_status.dart';
import '../../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'subscription_status_bloc.freezed.dart';

part 'subscription_status_event.dart';

part 'subscription_status_state.dart';

@injectable
class SubscriptionStatusBloc
    extends Bloc<SubscriptionStatusEvent, SubscriptionStatusState> {
  final ICrowdActionRepository _crowdActionRepository;

  SubscriptionStatusBloc(this._crowdActionRepository)
      : super(const SubscriptionStatusState.initial());

  @override
  Stream<SubscriptionStatusState> mapEventToState(
      SubscriptionStatusEvent event) async* {
    yield* event.map(
      checkParticipationStatus: _mapCheckParticipationStatusToState,
    );
  }

  Stream<SubscriptionStatusState> _mapCheckParticipationStatusToState(
      _CheckParticipationStatus value) async* {
    yield const SubscriptionStatusState.checkingSubscriptionStatus();

    final subscriptionStatus = await _crowdActionRepository
        .checkCrowdActionSubscriptionStatus(value.action);

    yield subscriptionStatus.fold(
      (failure) =>
          const SubscriptionStatusState.checkingSubscriptionStatusFailed(),
      (status) => SubscriptionStatusState.subscriptionStatus(status),
    );
  }
}
