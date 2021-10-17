part of 'crowdaction_getter_bloc.dart';

@freezed
class CrowdActionGetterState with _$CrowdActionGetterState {
  const factory CrowdActionGetterState.initial() = _Initial;

  const factory CrowdActionGetterState.fetchingCrowdActions() =
      _FetchingCrowdActions;

  const factory CrowdActionGetterState.noCrowdActions() = _NoCrowdActions;

  const factory CrowdActionGetterState.fetched(List<CrowdAction> crowdActions) =
      _Fetched;
}
