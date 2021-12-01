part of 'subscribe_bloc.dart';

@freezed
class SubscribeEvent with _$SubscribeEvent {
  const factory SubscribeEvent.participate(CrowdAction action) = _Participate;
  const factory SubscribeEvent.withDrawParticipation(CrowdAction action) =
      _WithDrawParticipation;
}
