import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/auth_success.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/user/i_user_repository.dart';
import '../../domain/user/user.dart';

part 'username_event.dart';
part 'username_state.dart';
part 'username_bloc.freezed.dart';

@injectable
class UsernameBloc extends Bloc<UsernameEvent, UsernameState> {
  final IAuthRepository profileRepository;
  Credential? _credential;
  StreamSubscription<Either<AuthFailure, AuthSuccess>>?
      _verifyStreamSubscription;

  UsernameBloc(this.profileRepository) : super(const UsernameState.initial()) {
    on<UsernameEvent>(
      (event, emit) async {
        await event.map(
          updateUsername: (event) async =>
              await _mapUpdateUsernameToState(emit, event),
        );
      },
    );
  }

  // update username
  FutureOr<void> _mapUpdateUsernameToState(
    Emitter<UsernameState> emit,
    _UpdateUsername event,
  ) async {
    emit(const UsernameState.awaitingUsernameUpdate());

    final failureOrSuccess = await profileRepository.updateUsername(
        firstname: event.firstname, lastname: event.lastname);

    emit(failureOrSuccess.fold(
      (failure) => UsernameState.updateFailed(failure),
      (_) => const UsernameState.usernameUpdateSuccessful(),
    ));
  }

  @override
  Future<void> close() async {
    _verifyStreamSubscription?.cancel();
    super.close();
  }
}
