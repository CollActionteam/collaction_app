part of 'top_participants_bloc.dart';

abstract class TopParticipantsState extends Equatable {
  const TopParticipantsState();

  const factory TopParticipantsState.initial() = _Initial;
  const factory TopParticipantsState.fetching() = _Fetching;
  const factory TopParticipantsState.fetched(
    List<Participation> topParticipants,
  ) = _Fetched;
  const factory TopParticipantsState.failure() = _Failure;

  @override
  List<Object?> get props => [];
}

class _Initial extends TopParticipantsState {
  const _Initial();
}

class _Fetching extends TopParticipantsState {
  const _Fetching();
}

class _Fetched extends TopParticipantsState {
  final List<Participation> topParticipants;

  const _Fetched(this.topParticipants);

  @override
  List<Object?> get props => [topParticipants];
}

class _Failure extends TopParticipantsState {
  const _Failure();
}
