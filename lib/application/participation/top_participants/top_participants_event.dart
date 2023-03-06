part of 'top_participants_bloc.dart';

abstract class TopParticipantsEvent extends Equatable {
  const TopParticipantsEvent();

  const factory TopParticipantsEvent.fetchParticipants({
    required String crowdActionId,
  }) = _FetchParticipants;
}

class _FetchParticipants extends TopParticipantsEvent {
  final String crowdActionId;

  const _FetchParticipants({required this.crowdActionId});

  @override
  List<Object?> get props => throw UnimplementedError();
}
