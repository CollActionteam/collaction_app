import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/participation/i_participation_repository.dart';
import '../../domain/participation/participation.dart';

part 'participation_bloc.freezed.dart';
part 'participation_event.dart';
part 'participation_state.dart';

@injectable
class ParticipationBloc extends Bloc<ParticipationEvent, ParticipationState> {
  final IParticipationRepository participationRepository;

  ParticipationBloc(this.participationRepository) : super(const _Loading()) {
    on<ParticipationEvent>((event, emit) async {
      await event.when(
        getParticipation: (crowdActionId) async {
          final failureOrParticipation = await participationRepository
              .getParticipation(crowdActionId: crowdActionId);

          emit(
            failureOrParticipation.fold(
              (failure) => const ParticipationState.notParticipating(),
              (participation) =>
                  ParticipationState.participating(participation),
            ),
          );
        },
        checkIn: () {
          // TODO: Implement once the backend has implemented it
        },
        toggleParticipation: (crowdActionId, commitmentOptions) async {
          emit(const ParticipationState.loading());

          await participationRepository.toggleParticipation(
            crowdActionId: crowdActionId,
            commitmentOptions: commitmentOptions,
          );

          add(
            ParticipationEvent.getParticipation(
              crowdActionId: crowdActionId,
            ),
          );
        },
      );
    });
  }
}
