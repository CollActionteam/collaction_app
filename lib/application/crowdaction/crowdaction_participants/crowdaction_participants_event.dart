part of 'crowdaction_participants_bloc.dart';

@freezed
class CrowdActionParticipantsEvent with _$CrowdActionParticipantsEvent {
  const factory CrowdActionParticipantsEvent.getParticipants({
    required String crowdActionId,
    @Default(1) int pageNumber,
  }) = _GetParticipants;
}
