part of 'crowdaction_details_bloc.dart';

abstract class CrowdActionDetailsState extends Equatable {
  const CrowdActionDetailsState();

  const factory CrowdActionDetailsState.initial() = Initial;
  const factory CrowdActionDetailsState.loadInProgress() = LoadInProgress;
  const factory CrowdActionDetailsState.loadSuccess(CrowdAction crowdAction) =
      LoadSuccess;
  const factory CrowdActionDetailsState.loadFailure(
    CrowdActionFailure crowdactionFailure,
  ) = LoadFailure;

    @override
  List<Object?> get props => [];
}

class Initial extends CrowdActionDetailsState {
  const Initial();
}

class LoadInProgress extends CrowdActionDetailsState {
  const LoadInProgress();
}

class LoadSuccess extends CrowdActionDetailsState {
  final CrowdAction crowdAction;

  const LoadSuccess(this.crowdAction);

    @override
  List<Object?> get props => [crowdAction];
}

class LoadFailure extends CrowdActionDetailsState {
  final CrowdActionFailure crowdactionFailure;

  const LoadFailure(this.crowdactionFailure);

    @override
  List<Object?> get props => [crowdactionFailure];
}
