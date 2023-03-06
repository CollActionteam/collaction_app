part of 'participation_bloc.dart';

abstract class ParticipationState extends Equatable {
  const ParticipationState();

  const factory ParticipationState.loading() = Loading;
  const factory ParticipationState.participating(Participation participation) =
      Participating;
  const factory ParticipationState.notParticipating() = NotParticipating;

  @override
  List<Object?> get props => [];
}

class Loading extends ParticipationState {
  const Loading();
}

class Participating extends ParticipationState {
  final Participation participation;

  const Participating(this.participation);

  @override
  List<Object?> get props => [participation];
}

class NotParticipating extends ParticipationState {
  const NotParticipating();
}
