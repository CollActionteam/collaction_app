part of 'participation_bloc.dart';

abstract class ParticipationState extends Equatable {
  const ParticipationState();

  const factory ParticipationState.loading() = _Loading;
  const factory ParticipationState.participating(Participation participation) =
      _Participating;
  const factory ParticipationState.notParticipating() = _NotParticipating;

  @override
  List<Object?> get props => [];
}

class _Loading extends ParticipationState {
  const _Loading();
}

class _Participating extends ParticipationState {
  final Participation participation;

  const _Participating(this.participation);

  @override
  List<Object?> get props => [participation];
}

class _NotParticipating extends ParticipationState {
  const _NotParticipating();
}
