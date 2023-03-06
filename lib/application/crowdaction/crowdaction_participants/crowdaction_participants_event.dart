part of 'crowdaction_participants_bloc.dart';

abstract class CrowdActionParticipantsEvent extends Equatable {
  const CrowdActionParticipantsEvent();

  const factory CrowdActionParticipantsEvent.init() = _Init;
  const factory CrowdActionParticipantsEvent.getParticipants({
    required String crowdActionId,
    int pageNumber,
  }) = _GetParticipants;

  @override
  List<Object?> get props => [];
}

class _Init extends CrowdActionParticipantsEvent {
  const _Init();
}

class _GetParticipants extends CrowdActionParticipantsEvent {
  final String crowdActionId;
  final int pageNumber;

  const _GetParticipants({required this.crowdActionId, this.pageNumber = 1});

  @override
  List<Object?> get props => [crowdActionId, pageNumber];
}
