part of 'spotlight_bloc.dart';

abstract class SpotlightState extends Equatable {
  const SpotlightState();

  const factory SpotlightState.initial() = Initial;

  // Spot light crowd actions
  const factory SpotlightState.fetchingCrowdSpotLightActions() =
      FetchingSpotLightCrowdActions;

  const factory SpotlightState.spotLightCrowdActionsError(
    CrowdActionFailure error,
  ) = SpotLightCrowdActionsError;

  const factory SpotlightState.spotLightCrowdActions(
    List<CrowdAction> crowdActions,
  ) = SpotLightCrowdActions;

  @override
  List<Object?> get props => [];
}

class Initial extends SpotlightState {
  const Initial();
}

// Spot light crowd actions
class FetchingSpotLightCrowdActions extends SpotlightState {
  const FetchingSpotLightCrowdActions();
}

class SpotLightCrowdActionsError extends SpotlightState {
  final CrowdActionFailure error;

  const SpotLightCrowdActionsError(this.error);

  @override
  List<Object?> get props => [error];
}

class SpotLightCrowdActions extends SpotlightState {
  final List<CrowdAction> crowdActions;

  const SpotLightCrowdActions(this.crowdActions);

  @override
  List<Object?> get props => [crowdActions];
}
