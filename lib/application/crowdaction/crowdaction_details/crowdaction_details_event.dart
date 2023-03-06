part of 'crowdaction_details_bloc.dart';

abstract class CrowdActionDetailsEvent extends Equatable {
  const CrowdActionDetailsEvent();

  const factory CrowdActionDetailsEvent.fetchCrowdAction({required String id}) =
      _FetchCrowdAction;

  @override
  List<Object?> get props => [];
}

class _FetchCrowdAction extends CrowdActionDetailsEvent {
  final String id;

  const _FetchCrowdAction({required this.id});

  @override
  List<Object?> get props => [id];
}
