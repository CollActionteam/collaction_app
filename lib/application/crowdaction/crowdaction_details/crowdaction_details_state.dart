part of 'crowdaction_details_bloc.dart';

abstract class CrowdActionDetailsState extends Equatable {
  const CrowdActionDetailsState();

  const factory CrowdActionDetailsState.initial() = _Initial;
  const factory CrowdActionDetailsState.loadInProgress() = _LoadInProgress;
  const factory CrowdActionDetailsState.loadSuccess(CrowdAction crowdAction) =
      _LoadSuccess;
  const factory CrowdActionDetailsState.loadFailure(
    CrowdActionFailure crowdactionFailure,
  ) = _LoadFailure;

    @override
  List<Object?> get props => [];
}

class _Initial extends CrowdActionDetailsState {
  const _Initial();
}

class _LoadInProgress extends CrowdActionDetailsState {
  const _LoadInProgress();
}

class _LoadSuccess extends CrowdActionDetailsState {
  final CrowdAction crowdAction;

  const _LoadSuccess(this.crowdAction);

    @override
  List<Object?> get props => [crowdAction];
}

class _LoadFailure extends CrowdActionDetailsState {
  final CrowdActionFailure crowdactionFailure;

  const _LoadFailure(this.crowdactionFailure);

    @override
  List<Object?> get props => [crowdactionFailure];
}
