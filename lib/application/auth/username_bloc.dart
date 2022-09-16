import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/user/i_profile_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/i_auth_repository.dart';

part 'username_event.dart';
part 'username_state.dart';
part 'username_bloc.freezed.dart';

@injectable
class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  final IProfileRepository profileRepository;

  UsernameBloc(this.profileRepository) : super(const _Initial()) {
    on<UsernameEvent>(
      (event, emit) async {
        await event.map(
          updateUsername: (event) async =>
              await _mapUpdateUsernameToState(emit, event),
        );
      },
    );
  }

  FutureOr<void> _mapUpdateUsernameToState(
    Emitter<UsernameState> emit,
    _UpdateUsername event,
  ) async {
    emit(const UsernameState.awaitingUsernameUpdate());

    final failureOrSuccess = await profileRepository.updateUsername(
      firstname: event.firstname,
      lastname: event.lastname,
    );

    emit(
      failureOrSuccess.fold(
        (failure) => const UsernameState.updateFailed(),
        (_) => const UsernameState.usernameUpdateSuccessful(),
      ),
    );
  }
}
