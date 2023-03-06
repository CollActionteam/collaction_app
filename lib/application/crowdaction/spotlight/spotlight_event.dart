part of 'spotlight_bloc.dart';

abstract class SpotlightEvent {
  const SpotlightEvent();

  const factory SpotlightEvent.getSpotLightCrowdActions() =
      _GetSpotlightCrowdActions;
}

class _GetSpotlightCrowdActions extends SpotlightEvent {
  const _GetSpotlightCrowdActions();
}
