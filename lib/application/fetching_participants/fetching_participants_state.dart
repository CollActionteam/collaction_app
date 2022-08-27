part of 'fetching_participants_bloc.dart';

@freezed
class FetchingParticipantsState with _$FetchingParticipantsState {
  const factory FetchingParticipantsState.initial() =
      _FetchingParticipantsInitial;
  const factory FetchingParticipantsState.fetchingParticipants() =
      _FetchingParticipants;
  const factory FetchingParticipantsState.fetched(
    List<Participant> participants,
  ) = _Fetched;
  const factory FetchingParticipantsState.failure(ProfileFailure failure) =
      _Failure;
}
