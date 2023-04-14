part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.userProfile,
    this.isEditing,
    this.wasProfilePictureUpdated,
  });

  final UserProfile? userProfile;
  final bool? isEditing;
  final bool? wasProfilePictureUpdated;

  factory ProfileState.initial() => const ProfileState(
        userProfile: null,
        isEditing: false,
        wasProfilePictureUpdated: false,
      );

  ProfileState copyWith({
    UserProfile? userProfile,
    bool? isEditing,
    bool? wasProfilePictureUpdated,
  }) {
    return ProfileState(
      userProfile: userProfile ?? this.userProfile,
      isEditing: isEditing ?? this.isEditing,
      wasProfilePictureUpdated:
          wasProfilePictureUpdated ?? false, // Reset state implicitly
    );
  }

  @override
  List<Object?> get props => [userProfile, isEditing, wasProfilePictureUpdated];
}
