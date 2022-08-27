part of 'profile_tab_bloc.dart';

class ProfileTabState {
  final List<CrowdAction> crowdActions;

  const ProfileTabState({required this.crowdActions});

  ProfileTabState copyWith({List<CrowdAction>? crowdActions}) {
    return ProfileTabState(crowdActions: crowdActions ?? this.crowdActions);
  }

  ProfileTabState.initial() : crowdActions = [];
}
