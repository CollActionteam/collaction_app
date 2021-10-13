import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/auth_success.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/user/i_user_repository.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  Credential? _credential;
  StreamSubscription<Either<AuthFailure, AuthSuccess>>?
      _verifyStreamSubscription;

  AuthBloc(this._authRepository) : super(const AuthState.initial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(
      verifyPhone: _mapVerifyPhoneToState,
      signInWithPhone: _mapSignInWithPhoneToState,
      updateUsername: _mapUpdateUsernameToState,
      updated: _mapUpdatedToState,
      reset: _mapResetToState,
      authCheckRequested: _mapAuthCheckRequestToState,
      signedOut: _mapSignOutToState,
    );
  }

  Stream<AuthState> _mapSignOutToState(_SignedOut value) async* {
    await _authRepository.signOut();
    yield const AuthState.unAuthenticated();
  }

  Stream<AuthState> _mapAuthCheckRequestToState(
      _AuthCheckRequested value) async* {
    final userOption = await _authRepository.getSignedInUser();

    /// TODO - If Auth is unAuthenticated, check if last state was pin input & go to it
    /// TODO - If Auth is authenticated, check if
    /// TODO - 1. If entire auth process was completed traverse to home
    /// TODO - 2. If 1. above is not true traverse to last auth page e.g enter username
    yield userOption.fold(
      () => const AuthState.unAuthenticated(),
      (a) => const AuthState.authenticated(),
    );
  }

  /// Reset auth state
  Stream<AuthState> _mapResetToState(value) async* {
    _verifyStreamSubscription?.cancel();
    _credential = null;
    yield const _Initial();
  }

  /// Handle auth updating state [_Updated]
  Stream<AuthState> _mapUpdatedToState(_Updated value) async* {
    yield value.failureOrCredential.fold(
      (failure) => AuthState.authError(failure),
      (r) {
        return r.map(
          codeSent: (e) {
            _credential = e.credential;
            return const AuthState.smsCodeSent();
          },
          codeRetrievalTimedOut: (e) {
            _credential = e.credential;
            return const AuthState.codeRetrievalTimedOut();
          },
          verificationCompleted: (e) {
            _credential = e.credential;
            return AuthState.verificationCompleted(_credential?.smsCode ?? '');
          },
        );
      },
    );
  }

  /// Update username in user profile [_UpdateUsername]
  Stream<AuthState> _mapUpdateUsernameToState(_UpdateUsername e) async* {
    yield const AuthState.awaitingUsernameUpdate();

    final failureOrSuccess =
        await _authRepository.updateUsername(username: e.username);

    yield failureOrSuccess.fold(
      (failure) => AuthState.authError(failure),
      (_) => const AuthState.usernameUpdateDone(),
    );
  }

  /// Submit phone for validation [_SignInWithPhone]
  Stream<AuthState> _mapSignInWithPhoneToState(_SignInWithPhone e) async* {
    yield const AuthState.signingInUser();

    if (_credential == null) {
      yield const AuthState.authError(AuthFailure.verificationFailed());
    } else {
      final authSuccessOrFailure = await _authRepository.signInWithPhone(
        authCredentials: _credential!.copyWith(smsCode: e.smsCode),
      );

      yield authSuccessOrFailure.fold(
        (failure) => AuthState.authError(failure),
        (success) => AuthState.loggedIn(isNewUser: success),
      );
    }
  }

  /// Submit SMS code for validation completion [_VerifyPhone]
  Stream<AuthState> _mapVerifyPhoneToState(_VerifyPhone e) async* {
    yield const AuthState.awaitingVerification();

    _verifyStreamSubscription =
        _authRepository.verifyPhone(phoneNumber: e.phoneNumber).listen(
              (failureOrCredential) =>
                  add(AuthEvent.updated(failureOrCredential)),
            );
  }

  @override
  Future<void> close() async {
    _verifyStreamSubscription?.cancel();
    super.close();
  }
}
