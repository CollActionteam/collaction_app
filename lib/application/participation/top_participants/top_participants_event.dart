part of 'top_participants_bloc.dart';

@freezed
class TopParticipantsEvent with _$TopParticipantsEvent {
  const factory TopParticipantsEvent.fetchParticipants({
    required String crowdActionId,
  }) = _FetchParticipants;
}
