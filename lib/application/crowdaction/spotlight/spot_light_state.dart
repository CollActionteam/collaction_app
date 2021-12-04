part of 'spot_light_bloc.dart';

@freezed
class SpotLightState with _$SpotLightState {
  const factory SpotLightState.initial() = _Initial;

  // Spot light crowd actions
  const factory SpotLightState.fetchingCrowdSpotLightActions() =
  _FetchingSpotLightCrowdActions;

  const factory SpotLightState.spotLightCrowdActionsError(
      CrowdActionFailure error) = _SpotLightCrowdActionsError;

  const factory SpotLightState.spotLightCrowdActions(
      List<CrowdAction> crowdActions) = _SpotLightCrowdActions;
}

