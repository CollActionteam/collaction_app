part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    required this.userProfile,
    this.isPicEditing,
    this.isBioEditing,
    this.wasProfilePictureUpdated,
    this.didPicSaveFail,
  });

  final UserProfile? userProfile;
  final bool? isPicEditing;
  final bool? isBioEditing;
  final bool? wasProfilePictureUpdated;
  final bool? didPicSaveFail;

  factory ProfileState.initial() => const ProfileState(
        userProfile: null,
        isPicEditing: false,
        isBioEditing: false,
        wasProfilePictureUpdated: false,
        didPicSaveFail: false,
      );

  ProfileState copyWith({
    UserProfile? userProfile,
    bool? isPicEditing,
    bool? isBioEditing,
    bool? wasProfilePictureUpdated,
    bool? didPicSaveFail,
  }) {
    return ProfileState(
      userProfile: userProfile ?? this.userProfile,
      isPicEditing: isPicEditing ?? this.isPicEditing,
      isBioEditing: isBioEditing ?? this.isBioEditing,
      wasProfilePictureUpdated:
          wasProfilePictureUpdated ?? false, // Reset state implicitly
      didPicSaveFail: didPicSaveFail ?? this.didPicSaveFail,
    );
  }

  @override
  List<Object?> get props => [
        userProfile,
        isPicEditing,
        isBioEditing,
        wasProfilePictureUpdated,
        didPicSaveFail
      ];
}
