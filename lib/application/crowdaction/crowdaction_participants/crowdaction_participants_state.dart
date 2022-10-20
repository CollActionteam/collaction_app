part of 'crowdaction_participants_bloc.dart';

@freezed
class CrowdActionParticipantsState with _$CrowdActionParticipantsState {
  const factory CrowdActionParticipantsState.initial() = _Initial;
  const factory CrowdActionParticipantsState.loading() = _Loading;
  const factory CrowdActionParticipantsState.success({
    required List<Participation> participants,
    required PageInfo pageInfo,
  }) = _Success;
  const factory CrowdActionParticipantsState.finished({
    required List<Participation> participants,
  }) = _Finished;
  const factory CrowdActionParticipantsState.failure(
    ParticipationFailure failure,
  ) = _Failure;
}
