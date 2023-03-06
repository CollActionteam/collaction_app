part of 'crowdaction_participants_bloc.dart';

abstract class CrowdActionParticipantsState extends Equatable {
  const CrowdActionParticipantsState();

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

  @override
  List<Object?> get props => [];
}

class _Initial extends CrowdActionParticipantsState {
  const _Initial();
}

class _Loading extends CrowdActionParticipantsState {
  const _Loading();
}

class _Success extends CrowdActionParticipantsState {
  final List<Participation> participants;
  final PageInfo pageInfo;

  const _Success({required this.participants, required this.pageInfo});
}

class _Finished extends CrowdActionParticipantsState {
  final List<Participation> participants;

  const _Finished({required this.participants});
}

class _Failure extends CrowdActionParticipantsState {
  final ParticipationFailure failure;

  const _Failure(this.failure);
}
