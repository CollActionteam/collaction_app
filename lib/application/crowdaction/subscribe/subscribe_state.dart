part of 'subscribe_bloc.dart';

@freezed
class SubscribeState with _$SubscribeState {
  const factory SubscribeState.initial() = _Initial;

  /// Subscription
  const factory SubscribeState.subscribingToCrowdAction() = _SubscribingToCrowdAction;
  const factory SubscribeState.subscriptionDone() = _SubscriptionDone;
  const factory SubscribeState.subscriptionFailed() = _SubscriptionFailed;

  /// Un subscription
  const factory SubscribeState.unSubscribingToCrowdAction() = _UnSubscribingToCrowdAction;
  const factory SubscribeState.unSubscriptionDone() = _UnSubscriptionDone;
}
