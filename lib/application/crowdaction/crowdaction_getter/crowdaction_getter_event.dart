part of 'crowdaction_getter_bloc.dart';

abstract class CrowdActionGetterEvent extends Equatable {
  const CrowdActionGetterEvent();

  const factory CrowdActionGetterEvent.init() = _Init;
  const factory CrowdActionGetterEvent.getCrowdActions({
    int pageNumber,
  }) = _GetCrowdActions;

  @override
  List<Object?> get props => [];
}

class _Init extends CrowdActionGetterEvent {
  const _Init();
}

class _GetCrowdActions extends CrowdActionGetterEvent {
  final int pageNumber;

  const _GetCrowdActions({this.pageNumber = 1});

  @override
  List<Object?> get props => [pageNumber];
}
