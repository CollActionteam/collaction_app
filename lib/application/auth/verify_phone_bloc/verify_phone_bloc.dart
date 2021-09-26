import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/auth/auth_success.dart';
import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'verify_phone_bloc.freezed.dart';

part 'verify_phone_event.dart';

part 'verify_phone_state.dart';

@injectable
class VerifyPhoneBloc extends Bloc<VerifyPhoneEvent, VerifyPhoneState> {
  final IAuthRepository _authRepository;
  Credential? _credential;
  StreamSubscription<Either<AuthFailure, AuthSuccess>>?
      _verifyStreamSubscription;

  VerifyPhoneBloc(this._authRepository)
      : super(const VerifyPhoneState.initial());

  @override
  Stream<VerifyPhoneState> mapEventToState(
    VerifyPhoneEvent event,
  ) async* {
    yield* event.map(
      verifyPhone: _mapVerifyPhoneToState,
      signInWithPhone: _mapSignInWithPhoneToState,
      updateUsername: _mapUpdateUsernameToState,
      updated: _mapUpdatedToState,
      reset: _mapResetToState,
    );
  }

  /// Reset auth state
  Stream<VerifyPhoneState> _mapResetToState(value) async* {
    _verifyStreamSubscription?.cancel();
    _credential = null;
    yield const _Initial();
  }

  /// Handle auth updating state [_Updated]
  Stream<VerifyPhoneState> _mapUpdatedToState(_Updated value) async* {
    yield value.failureOrCredential.fold(
      (failure) => VerifyPhoneState.authError(failure),
      (r) {
        return r.map(
          codeSent: (e) {
            _credential = e.credential;
            return const VerifyPhoneState.smsCodeSent();
          },
          codeRetrievalTimedOut: (e) {
            _credential = e.credential;
            return const VerifyPhoneState.codeRetrievalTimedOut();
          },
          verificationCompleted: (e) {
            _credential = e.credential;
            return VerifyPhoneState.verificationCompleted(
                _credential?.smsCode ?? '');
          },
        );
      },
    );
  }

  /// Update username in user profile [_UpdateUsername]
  Stream<VerifyPhoneState> _mapUpdateUsernameToState(_UpdateUsername e) async* {
    yield const VerifyPhoneState.awaitingUsernameUpdate();

    final failureOrSuccess =
        await _authRepository.updateUsername(username: e.username);

    yield failureOrSuccess.fold(
      (failure) => VerifyPhoneState.authError(failure),
      (_) => const VerifyPhoneState.usernameUpdateDone(),
    );
  }

  /// Submit phone for validation [_SignInWithPhone]
  Stream<VerifyPhoneState> _mapSignInWithPhoneToState(
      _SignInWithPhone e) async* {
    yield const VerifyPhoneState.signingInUser();

    if (_credential == null) {
      yield const VerifyPhoneState.authError(AuthFailure.verificationFailed());
    } else {
      final authSuccessOrFailure = await _authRepository.signInWithPhone(
        authCredentials: _credential!.copyWith(smsCode: e.smsCode),
      );

      yield authSuccessOrFailure.fold(
        (failure) => VerifyPhoneState.authError(failure),
        (success) => VerifyPhoneState.loggedIn(isNewUser: success),
      );
    }
  }

  /// Submit SMS code for validation completion [_VerifyPhone]
  Stream<VerifyPhoneState> _mapVerifyPhoneToState(_VerifyPhone e) async* {
    yield const VerifyPhoneState.awaitingVerification();

    _verifyStreamSubscription =
        _authRepository.verifyPhone(phoneNumber: e.phoneNumber).listen(
              (failureOrCredential) =>
                  add(VerifyPhoneEvent.updated(failureOrCredential)),
            );
  }

  @override
  Future<void> close() async {
    _verifyStreamSubscription?.cancel();
    super.close();
  }
}
