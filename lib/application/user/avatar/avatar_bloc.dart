import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/user/i_avatar_repository.dart';

part 'avatar_bloc.freezed.dart';
part 'avatar_event.dart';
part 'avatar_state.dart';

@injectable
class AvatarBloc extends Bloc<AvatarEvent, AvatarState> {
  final IAvatarRepository avatarRepository;

  AvatarBloc(this.avatarRepository) : super(const _Initial()) {
    on<AvatarEvent>((event, emit) async {
      await event.when(
        started: () {},
        uploadAvatar: (image) async {
          emit(const AvatarState.uploading());

          final uploadAvatar = await avatarRepository.uploadAvatar(image);

          emit(
            uploadAvatar.fold(
              (failure) => const AvatarState.uploadFailed(),
              (success) => const AvatarState.uploadSuccess(),
            ),
          );
        },
      );
    });
  }
}
