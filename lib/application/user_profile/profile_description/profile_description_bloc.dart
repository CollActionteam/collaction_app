import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'profile_description_bloc.freezed.dart';
part 'profile_description_event.dart';
part 'profile_description_state.dart';

@injectable
class ProfileDescriptionBloc
    extends Bloc<ProfileDescriptionEvent, ProfileDescriptionState> {
  ProfileDescriptionBloc() : super(const ProfileDescriptionState.initial()) {
    on<ProfileDescriptionEvent>(
      (event, emit) async {
        await event.map(
          editProfilePressed: (event) async =>
              await _editProfilePressed(emit, event),
          saveChangesPressed: (event) async =>
              await _saveChangesPressed(emit, event),
          cancelPressed: (event) async => await _cancelPressed(emit, event),
        );
      },
    );
  }

  FutureOr<void> _editProfilePressed(
    Emitter<ProfileDescriptionState> emit,
    _EditProfilePressed event,
  ) async {
    emit(const ProfileDescriptionState.modifyingDescription());
  }

  FutureOr<void> _saveChangesPressed(
    Emitter<ProfileDescriptionState> emit,
    _SaveChangesPressed event,
  ) async {
    emit(const ProfileDescriptionState.updatingDescription());
  }

  FutureOr<void> _cancelPressed(
    Emitter<ProfileDescriptionState> emit,
    _CancelPressed event,
  ) async {
    emit(const ProfileDescriptionState.updatingDescription());
  }
}
