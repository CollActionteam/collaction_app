part of 'subscription_bloc.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const SubscriptionState._();

  const factory SubscriptionState({
    required List<String> activeCommitments,
    required List<CommitmentOption> commitments,
    required bool deactivated,
  }) = _SubscriptionState;

  /// Initial State
  factory SubscriptionState.initial() => const SubscriptionState(
        activeCommitments: [],
        commitments: [],
        deactivated: false,
      );

  /// Subscription
  const factory SubscriptionState.subscribingToCrowdAction({
    required List<String> activeCommitments,
    required List<CommitmentOption> commitments,
    required bool deactivated,
  }) = SubscribingToCrowdAction;

  const factory SubscriptionState.subscribed({
    required List<String> activeCommitments,
    required List<CommitmentOption> commitments,
    required bool deactivated,
  }) = Subscribed;

  const factory SubscriptionState.subscriptionFailed({
    required List<String> activeCommitments,
    required List<CommitmentOption> commitments,
    required bool deactivated,
  }) = SubscriptionFailed;

  /// Un subscription
  const factory SubscriptionState.unsubscribingFromCrowdAction({
    required List<String> activeCommitments,
    required List<CommitmentOption> commitments,
    required bool deactivated,
  }) = UnsubscribingFromCrowdAction;

  const factory SubscriptionState.unsubscribed({
    required List<String> activeCommitments,
    required List<CommitmentOption> commitments,
    required bool deactivated,
  }) = _Unsubscribed;

  const factory SubscriptionState.unsubscribingFailed({
    required List<String> activeCommitments,
    required List<CommitmentOption> commitments,
    required bool deactivated,
  }) = UnsubscribingFailed;
}
