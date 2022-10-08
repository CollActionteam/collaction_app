import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/profile/user_profile.dart';
import '../../../domain/user/i_avatar_repository.dart';
import '../../../domain/user/i_profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository _profileRepository;
  final IAvatarRepository _avatarRepository;

  ProfileBloc(this._profileRepository, this._avatarRepository)
      : super(ProfileState.initial()) {
    on<GetUserProfile>((event, emit) async {
      final userOrFailure = await _profileRepository.getUserProfile();

      emit(
        await userOrFailure.fold(
          (failure) => const ProfileState(
            userProfile: null,
            isPicEditing: false,
            isBioEditing: false,
          ),
          (userProfile) => state.copyWith(
            userProfile: userProfile,
            isPicEditing: false,
            isBioEditing: false,
          ),
        ),
      );
    });

    on<EditBio>((event, emit) {
      emit(state.copyWith(isBioEditing: true));
    });

    on<EditProfilePic>((event, emit) {
      emit(state.copyWith(isPicEditing: true));
    });

    on<SaveBio>((event, emit) async {
      if (event.bio != null) {
        await _profileRepository.saveProfile(bio: event.bio);
      }

      final userOrFailure = await _profileRepository.getUserProfile();

      emit(
        userOrFailure.fold(
          (failure) => state.copyWith(isBioEditing: false),
          (userProfile) => state.copyWith(
            userProfile: userProfile,
            isBioEditing: false,
          ),
        ),
      );
    });

    on<SaveProfilePic>((event, emit) async {
      final wasImageUpdated = event.image != null;
      if (wasImageUpdated) {
        await _avatarRepository.uploadAvatar(event.image!);
      }

      // TODO handle could not upload profile picture!
      final userOrFailure = await _profileRepository.getUserProfile();

      emit(
        userOrFailure.fold(
          (failure) => state.copyWith(isPicEditing: false),
          (userProfile) => state.copyWith(
            userProfile: userProfile,
            isPicEditing: false,
            wasProfilePictureUpdated: wasImageUpdated,
          ),
        ),
      );
    });

    on<CancelEditProfilePic>((event, emit) {
      emit(state.copyWith(isPicEditing: false));
    });
  }
}
