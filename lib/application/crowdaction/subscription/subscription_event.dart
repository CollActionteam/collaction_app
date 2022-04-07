part of 'subscription_bloc.dart';

@freezed
class SubscriptionEvent with _$SubscriptionEvent {
  const factory SubscriptionEvent.participate(
    CrowdAction action,
    List<String> commitments,
    String? password,
  ) = _Participate;

  const factory SubscriptionEvent.withdrawParticipation(CrowdAction action) =
      _WithdrawParticipation;

  // Commitments
  const factory SubscriptionEvent.setActiveCommitments(
    List<String> commitments,
  ) = _SetActiveCommitment;

  const factory SubscriptionEvent.selectCommitment(
    CommitmentOption commitmentOption,
  ) = _SelectCommitment;

  const factory SubscriptionEvent.deselectCommitment(
    CommitmentOption commitmentOption,
  ) = _DeselectCommitment;

  const factory SubscriptionEvent.reset() = _Reset;

  const factory SubscriptionEvent.setDeactivatedState({
    required bool isDeactivated,
  }) = _SetDeactivatedState;

  const factory SubscriptionEvent.setCommitments(CrowdAction crowdAction) =
      _SetCommitments;
}
