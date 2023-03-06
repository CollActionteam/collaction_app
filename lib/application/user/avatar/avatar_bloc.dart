import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/user/i_avatar_repository.dart';

part 'avatar_event.dart';
part 'avatar_state.dart';

@injectable
class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final IAvatarRepository avatarRepository;

  AvatarBloc(this.avatarRepository) : super(const _Initial()) {
    on<AvatarEvent>((event, emit) async {
      if (event is _UploadAvatar) {
        emit(const AvatarState.uploading());

        final uploadAvatar = await avatarRepository.uploadAvatar(event.image);

        emit(
          uploadAvatar.fold(
            (failure) => const AvatarState.uploadFailed(),
            (success) => const AvatarState.uploadSuccess(),
          ),
        );
      }
    });
  }
}
