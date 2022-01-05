part of 'profile_bloc.dart';

class ProfileState {
  const ProfileState({
    required this.userProfile,
    this.isEditing,
  });

  final UserProfile? userProfile;
  final bool? isEditing;

  factory ProfileState.initial() => const ProfileState(
        userProfile: null,
        isEditing: false,
      );

  ProfileState copyWith({
    UserProfile? userProfile,
    bool? isEditing,
  }) {
    return ProfileState(
      userProfile: userProfile ?? this.userProfile,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
