part of 'participation_bloc.dart';

@freezed
class ParticipationState with _$ParticipationState {
  const factory ParticipationState.loading() = _Loading;
  const factory ParticipationState.participating(Participation participation) =
      _Participating;
  const factory ParticipationState.notParticipating() = _NotParticipating;
}
