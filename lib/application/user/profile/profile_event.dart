part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetUserProfile extends ProfileEvent {}

class EditBio extends ProfileEvent {}

class SaveBio extends ProfileEvent {
  final String? bio;
  SaveBio({
    this.bio,
  });
}

class CancelBio extends ProfileEvent {}

class EditProfilePic extends ProfileEvent {}

class SaveProfilePic extends ProfileEvent {
  final File? image;

  SaveProfilePic({
    this.image,
  });
}

class CancelEditProfilePic extends ProfileEvent {}
