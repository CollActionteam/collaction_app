import 'dart:io';

import 'package:bloc/bloc.dart';
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
        userOrFailure.fold(
          (failure) => state.copyWith(isEditing: false),
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

      if (event.image != null) {
        final uploadURI = await _avatarRepository.getAvatarUploadPath();
        uploadURI.fold(
          (_) => null,
          (uri) async {
            await _avatarRepository.uploadAvatar(event.image!, uri);
          },
        );
      }

      final userOrFailure = await _profileRepository.getUserProfile();

      emit(
        userOrFailure.fold(
          (failure) => state.copyWith(isEditing: false),
          (userProfile) => state.copyWith(
            userProfile: userProfile,
            isEditing: false,
          ),
        ),
      );
    });

    on<CancelEditProfile>((event, emit) {
      emit(state.copyWith(isEditing: false));
    });
  }
}
