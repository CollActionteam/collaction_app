import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/crowdaction_failures.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'crowdaction_details_event.dart';
part 'crowdaction_details_state.dart';

@injectable
class CrowdActionDetailsBloc
    extends Bloc<CrowdActionDetailsEvent, CrowdActionDetailsState> {
  final ICrowdActionRepository crowdActionRepository;

  CrowdActionDetailsBloc(this.crowdActionRepository)
      : super(const CrowdActionDetailsState.initial()) {
    on<CrowdActionDetailsEvent>((event, emit) async {
      if (event is _FetchCrowdAction) {
        final crowdActionOrFailure =
            await crowdActionRepository.getCrowdAction(event.id);

        crowdActionOrFailure.fold(
          (failure) {
            emit(CrowdActionDetailsState.loadFailure(failure));
          },
          (crowdAction) {
            emit(CrowdActionDetailsState.loadSuccess(crowdAction));
          },
        );
      }
    });
  }
}
