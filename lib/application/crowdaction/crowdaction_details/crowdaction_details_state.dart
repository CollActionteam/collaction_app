part of 'crowdaction_details_bloc.dart';

@freezed
class CrowdActionDetailsState with _$CrowdActionDetailsState {
  const factory CrowdActionDetailsState.initial() = _Initial;
  const factory CrowdActionDetailsState.loadInProgress() = _LoadInProgress;
  const factory CrowdActionDetailsState.loadSuccess(CrowdAction crowdAction) =
      _LoadSuccess;
  const factory CrowdActionDetailsState.loadFailure(
    CrowdActionFailure crowdactionFailure,
  ) = _LoadFailure;
}
