part of 'participation_bloc.dart';

@freezed
class ParticipationEvent with _$ParticipationEvent {
  const factory ParticipationEvent.getParticipation({
    required String crowdActionId,
  }) = _GetParticipation;
  const factory ParticipationEvent.checkIn() = _CheckIn;
  const factory ParticipationEvent.toggleParticipation({
    required String crowdActionId,
    List<String>? commitments,
  }) = _ToggleParticipation;
}
