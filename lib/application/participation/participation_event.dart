part of 'participation_bloc.dart';

abstract class ParticipationEvent extends Equatable {
  const ParticipationEvent();

  const factory ParticipationEvent.getParticipation({
    required String crowdActionId,
  }) = _GetParticipation;
  const factory ParticipationEvent.checkIn() = _CheckIn;
  const factory ParticipationEvent.toggleParticipation({
    required String crowdActionId,
    List<String>? commitments,
  }) = _ToggleParticipation;

  @override
  List<Object?> get props => [];
}

class _GetParticipation extends ParticipationEvent {
  final String crowdActionId;

  const _GetParticipation({required this.crowdActionId});

  @override
  List<Object?> get props => [crowdActionId];
}

class _CheckIn extends ParticipationEvent {
  const _CheckIn();
}

class _ToggleParticipation extends ParticipationEvent {
  final String crowdActionId;
  final List<String>? commitments;

  const _ToggleParticipation({required this.crowdActionId, this.commitments});

  @override
  List<Object?> get props => [crowdActionId, commitments];
}
