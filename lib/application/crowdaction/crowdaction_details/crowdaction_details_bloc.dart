import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/crowdaction_failures.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'crowdaction_details_bloc.freezed.dart';
part 'crowdaction_details_event.dart';
part 'crowdaction_details_state.dart';

@injectable
class CrowdActionDetailsBloc
    extends Bloc<CrowdActionDetailsEvent, CrowdActionDetailsState> {
  final ICrowdActionRepository crowdActionRepository;

  CrowdActionDetailsBloc(this.crowdActionRepository) : super(const _Initial()) {
    on<CrowdActionDetailsEvent>((event, emit) async {
      await event.when(
        fetchCrowdAction: (crowdActionId) async {
          final crowdActionOrFailure =
              await crowdActionRepository.getCrowdAction(crowdActionId);

          crowdActionOrFailure.fold(
            (failure) {
              emit(CrowdActionDetailsState.loadFailure(failure));
            },
            (crowdAction) {
              emit(CrowdActionDetailsState.loadSuccess(crowdAction));
            },
          );
        },
      );
    });
  }
}
