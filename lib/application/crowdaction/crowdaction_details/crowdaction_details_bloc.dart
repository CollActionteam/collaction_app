import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_app/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'crowdaction_details_event.dart';
part 'crowdaction_details_state.dart';
part 'crowdaction_details_bloc.freezed.dart';

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
