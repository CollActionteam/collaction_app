part of 'subscription_bloc.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial() = _Initial;

  /// Subscription
  const factory SubscriptionState.subscribingToCrowdAction() =
      SubscribingToCrowdAction;

  const factory SubscriptionState.subscribed() = Subscribed;

  const factory SubscriptionState.subscriptionFailed() = SubscriptionFailed;

  /// Un subscription
  const factory SubscriptionState.unsubscribingFromCrowdAction() =
      UnsubscribingFromCrowdAction;

  const factory SubscriptionState.unsubscribed() = _Unsubscribed;

  const factory SubscriptionState.unsubscribingFailed() = UnsubscribingFailed;
}
