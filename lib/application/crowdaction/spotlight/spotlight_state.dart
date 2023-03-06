part of 'spotlight_bloc.dart';

abstract class SpotlightState extends Equatable {
  const SpotlightState();

  const factory SpotlightState.initial() = _Initial;

  // Spot light crowd actions
  const factory SpotlightState.fetchingCrowdSpotLightActions() =
      _FetchingSpotLightCrowdActions;

  const factory SpotlightState.spotLightCrowdActionsError(
    CrowdActionFailure error,
  ) = _SpotLightCrowdActionsError;

  const factory SpotlightState.spotLightCrowdActions(
    List<CrowdAction> crowdActions,
  ) = _SpotLightCrowdActions;

  @override
  List<Object?> get props => [];
}

class _Initial extends SpotlightState {
  const _Initial();
}

// Spot light crowd actions
class _FetchingSpotLightCrowdActions extends SpotlightState {
  const _FetchingSpotLightCrowdActions();
}

class _SpotLightCrowdActionsError extends SpotlightState {
  final CrowdActionFailure error;

  const _SpotLightCrowdActionsError(this.error);

  @override
  List<Object?> get props => [error];
}

class _SpotLightCrowdActions extends SpotlightState {
  final List<CrowdAction> crowdActions;

  const _SpotLightCrowdActions(this.crowdActions);

  @override
  List<Object?> get props => [crowdActions];
}
