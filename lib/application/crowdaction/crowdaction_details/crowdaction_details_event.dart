part of 'crowdaction_details_bloc.dart';

@freezed
class CrowdActionDetailsEvent with _$CrowdActionDetailsEvent {
  const factory CrowdActionDetailsEvent.fetchCrowdAction({required String id}) =
      _FetchCrowdAction;
}
