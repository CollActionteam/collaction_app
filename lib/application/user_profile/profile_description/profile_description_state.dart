part of 'profile_description_bloc.dart';

@freezed
class ProfileDescriptionState with _$ProfileDescriptionState {
  const factory ProfileDescriptionState.initial() = _Initial;

  const factory ProfileDescriptionState.updatingDescription() =
      _UpdatingDescription;

  const factory ProfileDescriptionState.updateDescriptionSuccess() =
      _UpdateDescriptionSuccess;

  const factory ProfileDescriptionState.updateDescriptionFailed() =
      _UpdateDescriptionFailed;

  const factory ProfileDescriptionState.modifyingDescription() =
      _ModifyingDescription;
}
