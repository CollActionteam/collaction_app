part of 'profile_description_bloc.dart';

@freezed
class ProfileDescriptionEvent with _$ProfileDescriptionEvent {
  const factory ProfileDescriptionEvent.editProfilePressed() =
      _EditProfilePressed;
  const factory ProfileDescriptionEvent.saveChangesPressed() =
      _SaveChangesPressed;

  const factory ProfileDescriptionEvent.cancelPressed() = _CancelPressed;
}
