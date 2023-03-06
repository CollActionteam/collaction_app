part of 'crowdaction_getter_bloc.dart';

abstract class CrowdActionGetterState extends Equatable {
  const CrowdActionGetterState();

  const factory CrowdActionGetterState.initial() = Initial;

  const factory CrowdActionGetterState.loading() = _Loading;

  const factory CrowdActionGetterState.success({
    required List<CrowdAction> crowdActions,
    required PageInfo pageInfo,
  }) = Success;

  const factory CrowdActionGetterState.finished({
    required List<CrowdAction> crowdActions,
  }) = Finished;

  const factory CrowdActionGetterState.failure(CrowdActionFailure failure) =
      _Failure;

  @override
  List<Object?> get props => [];
}

class Initial extends CrowdActionGetterState {
  const Initial();
}

class _Loading extends CrowdActionGetterState {
  const _Loading();
}

class Success extends CrowdActionGetterState {
  final List<CrowdAction> crowdActions;
  final PageInfo pageInfo;

  const Success({required this.crowdActions, required this.pageInfo});
}

class Finished extends CrowdActionGetterState {
  final List<CrowdAction> crowdActions;

  const Finished({required this.crowdActions});
}

class _Failure extends CrowdActionGetterState {
  final CrowdActionFailure failure;

  const _Failure(this.failure);
}
