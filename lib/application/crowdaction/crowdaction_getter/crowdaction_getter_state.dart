part of 'crowdaction_getter_bloc.dart';

abstract class CrowdActionGetterState extends Equatable {
  const CrowdActionGetterState();

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

  @override
  List<Object?> get props => [];
}

class _Initial extends CrowdActionGetterState {
  const _Initial();
}

class _Loading extends CrowdActionGetterState {
  const _Loading();
}

class _Success extends CrowdActionGetterState {
  final List<CrowdAction> crowdActions;
  final PageInfo pageInfo;

  const _Success({required this.crowdActions, required this.pageInfo});
}

class _Finished extends CrowdActionGetterState {
  final List<CrowdAction> crowdActions;

  const _Finished({required this.crowdActions});
}

class _Failure extends CrowdActionGetterState {
  final CrowdActionFailure failure;
  
  const _Failure(this.failure);
}
