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
      : super(const SubscriptionStatusState.initial()) {
    on<SubscriptionStatusEvent>(
      (event, emit) async {
        await event.map(
          checkParticipationStatus: (event) =>
              _mapCheckParticipationStatusToState(emit, event),
        );
      },
    );
  }

  FutureOr<void> _mapCheckParticipationStatusToState(
    Emitter<SubscriptionStatusState> emit,
    _CheckParticipationStatus value,
  ) async {
    emit(const SubscriptionStatusState.checkingSubscriptionStatus());

    final subscriptionStatus = await _crowdActionRepository
        .checkCrowdActionSubscriptionStatus(value.action);

    emit(
      subscriptionStatus.fold(
        (failure) =>
            const SubscriptionStatusState.checkingSubscriptionStatusFailed(),
        (status) => SubscriptionStatusState.subscriptionStatus(status),
      ),
    );
  }
}
