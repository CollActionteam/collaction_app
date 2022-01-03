part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetUserProfile extends ProfileEvent {}

class EditProfile extends ProfileEvent {}

class SaveProfile extends ProfileEvent {
  final String? bio;
  final File? image;

  SaveProfile({
    this.bio,
    this.image,
  });
}

class CancelEditProfile extends ProfileEvent {}
