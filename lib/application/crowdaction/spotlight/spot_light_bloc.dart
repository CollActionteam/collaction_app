import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../../domain/crowdaction/crowdaction_failures.dart';
import '../../../domain/crowdaction/i_crowdaction_repository.dart';

part 'spot_light_bloc.freezed.dart';
part 'spot_light_event.dart';
part 'spot_light_state.dart';

@injectable
class SpotLightBloc extends Bloc<SpotLightEvent, SpotLightState> {
  final ICrowdActionRepository _crowdActionRepository;

  SpotLightBloc(this._crowdActionRepository)
      : super(const SpotLightState.initial());

  @override
  Stream<SpotLightState> mapEventToState(SpotLightEvent event) async* {
    yield* event.map(
        getSpotLightCrowdActions: _mapGetSpotLightCrowdActionsToState);
  }

  Stream<SpotLightState> _mapGetSpotLightCrowdActionsToState(
      _GetSpotlightCrowdActions value) async* {
    yield const SpotLightState.fetchingCrowdSpotLightActions();

    final spotlightCrowdActionsResult =
        await _crowdActionRepository.getSpotLightCrowdActions();

    yield spotlightCrowdActionsResult.fold(
      (failure) => SpotLightState.spotLightCrowdActionsError(failure),
      (spotLightCrowdActions) =>
          SpotLightState.spotLightCrowdActions(spotLightCrowdActions),
    );
  }
}
