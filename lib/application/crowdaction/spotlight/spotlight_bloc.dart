import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/crowdaction_failures.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'spotlight_bloc.freezed.dart';
part 'spotlight_event.dart';
part 'spotlight_state.dart';

@injectable
class SpotlightBloc extends Bloc<SpotlightEvent, SpotlightState> {
  final ICrowdActionRepository _crowdActionRepository;

  SpotlightBloc(this._crowdActionRepository)
      : super(const SpotlightState.initial());

  @override
  Stream<SpotlightState> mapEventToState(SpotlightEvent event) async* {
    yield* event.map(
        getSpotLightCrowdActions: _mapGetSpotLightCrowdActionsToState);
  }

  Stream<SpotlightState> _mapGetSpotLightCrowdActionsToState(
      _GetSpotlightCrowdActions value) async* {
    yield const SpotlightState.fetchingCrowdSpotLightActions();

    final spotlightCrowdActionsResult =
        await _crowdActionRepository.getSpotlightCrowdActions();

    yield spotlightCrowdActionsResult.fold(
      (failure) => SpotlightState.spotLightCrowdActionsError(failure),
      (spotLightCrowdActions) =>
          SpotlightState.spotLightCrowdActions(spotLightCrowdActions),
    );
  }
}
