part of 'subscription_status_bloc.dart';

@freezed
class SubscriptionStatusState with _$SubscriptionStatusState {
  const factory SubscriptionStatusState.initial() = _Initial;

  /// Checking Subscription Status
  const factory SubscriptionStatusState.checkingSubscriptionStatus() =
      CheckingSubscriptionStatus;

  const factory SubscriptionStatusState.subscriptionStatus(
      CrowdActionStatus status) = SubscriptionStatus;

  const factory SubscriptionStatusState.checkingSubscriptionStatusFailed() =
      _CheckingSubscriptionStatusFailed;
}
