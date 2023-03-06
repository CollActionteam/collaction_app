part of 'crowdaction_participants_bloc.dart';

abstract class CrowdActionParticipantsState extends Equatable {
  const CrowdActionParticipantsState();

  const factory CrowdActionParticipantsState.initial() = Initial;
  const factory CrowdActionParticipantsState.loading() = _Loading;
  const factory CrowdActionParticipantsState.success({
    required List<Participation> participants,
    required PageInfo pageInfo,
  }) = Success;
  const factory CrowdActionParticipantsState.finished({
    required List<Participation> participants,
  }) = Finished;
  const factory CrowdActionParticipantsState.failure(
    ParticipationFailure failure,
  ) = _Failure;

  @override
  List<Object?> get props => [];
}

class Initial extends CrowdActionParticipantsState {
  const Initial();
}

class _Loading extends CrowdActionParticipantsState {
  const _Loading();
}

class Success extends CrowdActionParticipantsState {
  final List<Participation> participants;
  final PageInfo pageInfo;

  const Success({required this.participants, required this.pageInfo});
}

class Finished extends CrowdActionParticipantsState {
  final List<Participation> participants;

  const Finished({required this.participants});
}

class _Failure extends CrowdActionParticipantsState {
  final ParticipationFailure failure;

  const _Failure(this.failure);
}
