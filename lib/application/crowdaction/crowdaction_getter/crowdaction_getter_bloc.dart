import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/page_info.dart';
import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/crowdaction_failures.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'crowdaction_getter_event.dart';
part 'crowdaction_getter_state.dart';

@injectable
class CrowdActionGetterBloc
    extends Bloc<CrowdActionGetterEvent, CrowdActionGetterState> {
  final ICrowdActionRepository _crowdActionRepository;

  CrowdActionGetterBloc(this._crowdActionRepository)
      : super(const CrowdActionGetterState.initial()) {
    on<CrowdActionGetterEvent>((event, emit) async {
      if (event is _Init) {
        emit(const CrowdActionGetterState.loading());
        emit(const CrowdActionGetterState.initial());
      } else if (event is _GetCrowdActions) {
        emit(const CrowdActionGetterState.loading());

        final paginatedCrowdActionsOrFailure =
            await _crowdActionRepository.getCrowdActions(
          pageNumber: event.pageNumber,
        );

        paginatedCrowdActionsOrFailure.fold(
            (failure) => emit(
                  CrowdActionGetterState.failure(failure),
                ), (paginatedCrowdActions) {
          if (paginatedCrowdActions.pageInfo.page ==
              paginatedCrowdActions.pageInfo.totalPages) {
            emit(
              CrowdActionGetterState.finished(
                crowdActions: paginatedCrowdActions.crowdActions,
              ),
            );
            return;
          }

          emit(
            CrowdActionGetterState.success(
              crowdActions: paginatedCrowdActions.crowdActions,
              pageInfo: paginatedCrowdActions.pageInfo,
            ),
          );
        });
      }
    });
  }
}
