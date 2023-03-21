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
            isEditing: false,
          ),
          (userProfile) => state.copyWith(
            userProfile: userProfile,
            isEditing: false,
          ),
        ),
      );
    });

    on<EditProfile>((event, emit) {
      emit(state.copyWith(isEditing: true));
    });

    on<SaveProfile>((event, emit) async {
      if (event.bio != null) {
        await _profileRepository.saveProfile(bio: event.bio);
      }
      final wasImageUpdated = event.image != null;
      if (wasImageUpdated) {
        await _avatarRepository.uploadAvatar(event.image!);
      }

      // TODO handle could not upload profile picture!
      final userOrFailure = await _profileRepository.getUserProfile();

      emit(
        userOrFailure.fold(
          (failure) => state.copyWith(isEditing: false),
          (userProfile) => state.copyWith(
            userProfile: userProfile,
            isEditing: false,
            wasProfilePictureUpdated: wasImageUpdated,
          ),
        ),
      );
    });

    on<CancelEditProfile>((event, emit) {
      emit(state.copyWith(isEditing: false));
    });

    on<GetOtherParticipantProfile>(
      (event, emit) async {
        final userProfileOrFailure = await _profileRepository.getUserProfile();
        emit(
          userProfileOrFailure.fold(
            (l) => state.copyWith(otherParticipantProfile: null),
            (participantProfile) =>
                state.copyWith(otherParticipantProfile: participantProfile),
          ),
        );
      },
    );
  }
}
