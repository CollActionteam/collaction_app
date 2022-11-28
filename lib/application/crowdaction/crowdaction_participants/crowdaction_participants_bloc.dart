import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/page_info.dart';
import '../../../domain/participation/i_participation_repository.dart';
import '../../../domain/participation/participation.dart';
import '../../../domain/participation/participation_failures.dart';

part 'crowdaction_participants_bloc.freezed.dart';
part 'crowdaction_participants_event.dart';
part 'crowdaction_participants_state.dart';

@injectable
class CrowdActionParticipantsBloc
    extends Bloc<CrowdActionParticipantsEvent, CrowdActionParticipantsState> {
  final IParticipationRepository participationRepository;

  CrowdActionParticipantsBloc(this.participationRepository)
      : super(const CrowdActionParticipantsState.initial()) {
    on<CrowdActionParticipantsEvent>((event, emit) async {
      await event.when(
        init: () async {
          emit(const CrowdActionParticipantsState.loading());
          emit(const CrowdActionParticipantsState.initial());
        },
        getParticipants: (crowdActionId, pageNumber) async {
          emit(const CrowdActionParticipantsState.loading());

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
