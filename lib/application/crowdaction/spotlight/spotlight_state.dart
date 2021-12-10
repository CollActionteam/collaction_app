part of 'spotlight_bloc.dart';

@freezed
class SpotlightState with _$SpotlightState {
  const factory SpotlightState.initial() = _Initial;

  // Spot light crowd actions
  const factory SpotlightState.fetchingCrowdSpotLightActions() =
      _FetchingSpotLightCrowdActions;

  const factory SpotlightState.spotLightCrowdActionsError(
      CrowdActionFailure error) = _SpotLightCrowdActionsError;

  const factory SpotlightState.spotLightCrowdActions(
      List<CrowdAction> crowdActions) = _SpotLightCrowdActions;
}
