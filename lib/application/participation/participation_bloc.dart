import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/participation/i_participation_repository.dart';
import '../../domain/participation/participation.dart';

part 'participation_event.dart';
part 'participation_state.dart';

@injectable
class ParticipationBloc extends Bloc<ParticipationEvent, ParticipationState> {
  final IParticipationRepository participationRepository;

  ParticipationBloc(this.participationRepository) : super(const Loading()) {
    on<ParticipationEvent>((event, emit) async {
      if (event is _GetParticipation) {
        final failureOrParticipation = await participationRepository
            .getParticipation(crowdActionId: event.crowdActionId);

        emit(
          failureOrParticipation.fold(
            (failure) => const ParticipationState.notParticipating(),
            (participation) => ParticipationState.participating(participation),
          ),
        );
      } else if (event is _CheckIn) {
        // TODO: Implement once the backend has implemented it
      } else if (event is _ToggleParticipation) {
        emit(const ParticipationState.loading());

        await participationRepository.toggleParticipation(
          crowdActionId: event.crowdActionId,
          commitments: event.commitments,
        );

        add(
          ParticipationEvent.getParticipation(
            crowdActionId: event.crowdActionId,
          ),
        );
      }
    });
  }
}
