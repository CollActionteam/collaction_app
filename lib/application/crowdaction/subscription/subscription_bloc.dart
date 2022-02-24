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
      : super(SubscriptionState.initial()) {
    on<SubscriptionEvent>(
      (event, emit) async {
        await event.map(
          participate: (event) => _mapParticipateToState(emit, event),
          withdrawParticipation: (event) =>
              _mapWithdrawParticipationToState(emit, event),
          setActiveCommitments: (value) =>
              _mapSetActiveCommitmentsToState(value, emit),
          selectCommitment: (value) => _mapSelectCommitmentToState(value, emit),
          deselectCommitment: (value) =>
              _mapDeselectCommitmentToState(value, emit),
          reset: (value) => _mapResetToState(value, emit),
          setCommitments: (value) => _mapSetCommitmentsToState(value, emit),
          setDeactivatedState: (value) =>
              _mapSetDeactivatedToState(value, emit),
        );
      },
    );
  }

  FutureOr<void> _mapWithdrawParticipationToState(
    Emitter<SubscriptionState> emit,
    _WithdrawParticipation value,
  ) async {
    emit(
      SubscriptionState.unsubscribingFromCrowdAction(
        commitments: state.commitments,
        activeCommitments: state.activeCommitments,
        deactivated: state.deactivated,
      ),
    );

    final failureOrSuccess =
        await _crowdActionRepository.unsubscribeFromCrowdAction(value.action);

    emit(
      failureOrSuccess.fold(
        (failure) => SubscriptionState.unsubscribingFailed(
          commitments: state.commitments,
          activeCommitments: state.activeCommitments,
          deactivated: state.deactivated,
        ),
        (_) => SubscriptionState.unsubscribed(
          commitments: state.commitments,
          activeCommitments: state.activeCommitments,
          deactivated: state.deactivated,
        ),
      ),
    );
  }

  FutureOr<void> _mapParticipateToState(
    Emitter<SubscriptionState> emit,
    _Participate value,
  ) async {
    emit(
      SubscriptionState.subscribingToCrowdAction(
        commitments: state.commitments,
        activeCommitments: state.activeCommitments,
        deactivated: state.deactivated,
      ),
    );

    final failureOrSuccess =
        await _crowdActionRepository.subscribeToCrowdAction(
      value.action,
      value.commitments,
      value.password,
    );

    emit(
      failureOrSuccess.fold(
        (failure) => SubscriptionState.subscriptionFailed(
          commitments: state.commitments,
          activeCommitments: state.activeCommitments,
          deactivated: state.deactivated,
        ),
        (_) => SubscriptionState.subscribed(
          commitments: state.commitments,
          activeCommitments: state.activeCommitments,
          deactivated: state.deactivated,
        ),
      ),
    );
  }

  FutureOr<void> _mapSetActiveCommitmentsToState(
    _SetActiveCommitment value,
    Emitter<SubscriptionState> emit,
  ) {
    emit(state.copyWith(activeCommitments: value.commitments));
  }

  FutureOr<void> _mapSelectCommitmentToState(
    _SelectCommitment value,
    Emitter<SubscriptionState> emit,
  ) {
    _selectCommitment(value.commitmentOption);
    emit(
      state.copyWith(
        activeCommitments: List.of(_activeCommitments),
      ),
    );
  }

  FutureOr<void> _mapDeselectCommitmentToState(
    _DeselectCommitment value,
    Emitter<SubscriptionState> emit,
  ) {
    _deselectCommitment(value.commitmentOption);
    emit(
      state.copyWith(
        activeCommitments: List.of(_activeCommitments),
      ),
    );
  }

  FutureOr<void> _mapResetToState(
    _Reset value,
    Emitter<SubscriptionState> emit,
  ) {
    emit(SubscriptionState.initial());
    _commitments.clear();
    _activeCommitments.clear();
  }

  FutureOr<void> _mapSetCommitmentsToState(
    _SetCommitments value,
    Emitter<SubscriptionState> emit,
  ) {
    emit(state.copyWith(commitments: value.crowdAction.commitmentOptions));
    _commitments.clear();
    _commitments.addAll(value.crowdAction.commitmentOptions);
  }

  FutureOr<void> _mapSetDeactivatedToState(
    _SetDeactivatedState value,
    Emitter<SubscriptionState> emit,
  ) {
    emit(state.copyWith(deactivated: value.isDeactivated));
  }

  final List<CommitmentOption> _commitments = [];
  List<String> _activeCommitments = [];

  void _selectAll(List<CommitmentOption> commitments) {
    for (final commitment in commitments) {
      child = commitment;
      while (child != null) {
        if (!_activeCommitments.contains(child.id)) {
          _activeCommitments.add(child.id);
        }
        child = child.requires;
      }
    }
  }

  void selectCommitments(List<String> commitments) {
    _activeCommitments.addAll(commitments);
    _activeCommitments = _activeCommitments.toSet().toList();
  }

  void _deselectCommitment(CommitmentOption option) {
    _activeCommitments.remove(option.id);

    final activeCommitmentOptions = _commitments
        .where((commitment) => _activeCommitments.contains(commitment.id));
    for (final commitment in activeCommitmentOptions) {
      if (commitment.requires?.contains(option) == true) {
        _deselectCommitment(commitment);
      }
    }
  }

  void _selectCommitment(CommitmentOption option) {
    _activeCommitments.add(option.id);

    final children = option.requires;
    if (children != null) {
      _selectAll(children);
    }
  }
}
