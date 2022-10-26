part of 'crowdaction_getter_bloc.dart';

@freezed
class CrowdActionGetterState with _$CrowdActionGetterState {
  const factory CrowdActionGetterState.initial() = _Initial;

  const factory CrowdActionGetterState.loading() = _Loading;

  const factory CrowdActionGetterState.success({
    required List<CrowdAction> crowdActions,
    required PageInfo pageInfo,
  }) = _Success;

  const factory CrowdActionGetterState.finished({
    required List<CrowdAction> crowdActions,
  }) = _Finished;
  const factory CrowdActionGetterState.failure(CrowdActionFailure failure) =
      _Failure;
}
