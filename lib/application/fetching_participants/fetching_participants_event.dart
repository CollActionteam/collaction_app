part of 'fetching_participants_bloc.dart';

@freezed
class FetchingParticipantsEvent with _$FetchingParticipantsEvent {
  const factory FetchingParticipantsEvent.fetchParticipants(
    String crowdactionId,
    int page,
  ) = _FetchParticipants;
}
