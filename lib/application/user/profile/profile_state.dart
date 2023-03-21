part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.userProfile,
    this.isEditing,
    this.wasProfilePictureUpdated,
    this.otherParticipantProfile,
  });

  final UserProfile? userProfile;
  final bool? isEditing;
  final bool? wasProfilePictureUpdated;
  final UserProfile? otherParticipantProfile;

  factory ProfileState.initial() => const ProfileState(
        userProfile: null,
        isEditing: false,
        wasProfilePictureUpdated: false,
        otherParticipantProfile: null,
      );

  ProfileState copyWith({
    UserProfile? userProfile,
    bool? isEditing,
    bool? wasProfilePictureUpdated,
    UserProfile? otherParticipantProfile,
  }) {
    return ProfileState(
        userProfile: userProfile ?? this.userProfile,
        isEditing: isEditing ?? this.isEditing,
        wasProfilePictureUpdated:
            wasProfilePictureUpdated ?? false, // Reset state implicitly
        otherParticipantProfile: otherParticipantProfile);
  }

  @override
  List<Object?> get props => [userProfile, isEditing, wasProfilePictureUpdated];
}
