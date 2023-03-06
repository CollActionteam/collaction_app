import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/page_info.dart';
import '../../../domain/participation/i_participation_repository.dart';
import '../../../domain/participation/participation.dart';
import '../../../domain/participation/participation_failures.dart';

part 'crowdaction_participants_event.dart';
part 'crowdaction_participants_state.dart';

@injectable
class CrowdActionParticipantsBloc
    extends Bloc<CrowdActionParticipantsEvent, CrowdActionParticipantsState> {
  final IParticipationRepository participationRepository;

  CrowdActionParticipantsBloc(this.participationRepository)
      : super(const CrowdActionParticipantsState.initial()) {
    on<CrowdActionParticipantsEvent>((event, emit) async {
      if (event is _Init) {
        emit(const CrowdActionParticipantsState.loading());
        emit(const CrowdActionParticipantsState.initial());
      } else if (event is _GetParticipants) {
        emit(const CrowdActionParticipantsState.loading());

        final paginatedParticipationsOrFailure =
            await participationRepository.getParticipations(
          crowdActionId: event.crowdActionId,
          pageNumber: event.pageNumber,
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
      }
    });
  }
}
