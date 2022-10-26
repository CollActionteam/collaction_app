part of 'top_participants_bloc.dart';

@freezed
class TopParticipantsState with _$TopParticipantsState {
  const factory TopParticipantsState.initial() = _Initial;
  const factory TopParticipantsState.fetching() = _Fetching;
  const factory TopParticipantsState.fetched(
    List<Participation> topParticipants,
  ) = _Fetched;
  const factory TopParticipantsState.failure() = _Failure;
}
