part of 'subscription_status_bloc.dart';

@freezed
class SubscriptionStatusEvent with _$SubscriptionStatusEvent {
  const factory SubscriptionStatusEvent.checkParticipationStatus(
    CrowdAction action,
  ) = _CheckParticipationStatus;
}
