import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/participation/i_participation_repository.dart';
import 'package:collaction_app/domain/participation/paginated_participations.dart';
import 'package:collaction_app/domain/participation/participation.dart';
import 'package:collaction_app/domain/participation/participation_failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'crowdaction_participants_bloc.freezed.dart';
part 'crowdaction_participants_event.dart';
part 'crowdaction_participants_state.dart';

@injectable
class CrowdActionParticipantsBloc
    extends Bloc<CrowdActionParticipantsEvent, CrowdActionParticipantsState> {
  final IParticipationRepository participationRepository;

  CrowdActionParticipantsBloc(this.participationRepository)
      : super(const _Initial()) {
    on<CrowdActionParticipantsEvent>((event, emit) async {
      emit(const CrowdActionParticipantsState.loading());

      await event.when(
        getParticipants: (crowdActionId, pageNumber) async {
          final paginatedParticipationsOrFailure =
              await participationRepository.getParticipations(
            crowdActionId: crowdActionId,
            pageNumber: pageNumber,
          );

          paginatedParticipationsOrFailure.fold(
            (failure) => emit(CrowdActionParticipantsState.failure(failure)),
            (paginatedParticipants) {
              if (paginatedParticipants.pageInfo.page ==
                  paginatedParticipants.pageInfo.totalPages) {
                emit(
                  CrowdActionParticipantsState.finished(
                    participants: paginatedParticipants.participations,
                  ),
                );
                return;
              }

              emit(
                CrowdActionParticipantsState.success(
                  participants: paginatedParticipants.participations,
                  pageInfo: paginatedParticipants.pageInfo,
                ),
              );
            },
          );
        },
      );
    });
  }
}
