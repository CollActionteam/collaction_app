part of 'subscribe_bloc.dart';

@freezed
class SubscribeState with _$SubscribeState {
  const factory SubscribeState.initial() = _Initial;

  /// Subscription
  const factory SubscribeState.subscribingToCrowdAction() =
      SubscribingToCrowdAction;
  const factory SubscribeState.subscriptionDone() = _SubscriptionDone;
  const factory SubscribeState.subscriptionFailed() = _SubscriptionFailed;

  /// Un subscription
  const factory SubscribeState.unSubscribingToCrowdAction() =
      UnSubscribingToCrowdAction;
  const factory SubscribeState.unSubscriptionDone() = _UnSubscriptionDone;
  const factory SubscribeState.unSubscriptionFailed() = _UnSubscriptionFailed;
}
