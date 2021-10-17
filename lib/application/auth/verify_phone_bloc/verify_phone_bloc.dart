import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/auth/auth_event.dart';
import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/auth/i_auth_facade.dart';
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
  final IAuthFacade _authFacade;
  Credential? _credential;

  VerifyPhoneBloc(this._authFacade) : super(const VerifyPhoneState.initial());

  @override
  Stream<VerifyPhoneState> mapEventToState(
    VerifyPhoneEvent event,
  ) async* {
    yield* event.map(
      verifyPhone: _mapVerifyPhoneToState,
      signInWithPhone: _mapSignInWithPhoneToState,
      updateUsername: _mapUpdateUsernameToState,
      updated: _mapUpdatedToState,
    );
  }

  Stream<VerifyPhoneState> _mapUpdatedToState(Updated value) async* {
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

  /// Update username in user profile [UpdateUsername]
  Stream<VerifyPhoneState> _mapUpdateUsernameToState(UpdateUsername e) async* {
    yield const VerifyPhoneState.awaitingUsernameUpdate();

    final failureOrSuccess =
        await _authFacade.updateUsername(username: e.username);

    yield failureOrSuccess.fold(
      (failure) => VerifyPhoneState.authError(failure),
      (_) => const VerifyPhoneState.usernameUpdateDone(),
    );
  }

  /// Submit phone for validation [SignInWithPhone]
  Stream<VerifyPhoneState> _mapSignInWithPhoneToState(
      SignInWithPhone e) async* {
    yield const VerifyPhoneState.signingInUser();

    if (_credential == null) {
      yield const VerifyPhoneState.authError(AuthFailure.verificationFailed());
    } else {
      final authSuccessOrFailure = await _authFacade.signInWithPhone(
        authCredentials: _credential!.copyWith(smsCode: e.smsCode),
      );

      yield authSuccessOrFailure.fold(
        (failure) => VerifyPhoneState.authError(failure),
        (success) => VerifyPhoneState.loggedIn(isNewUser: success),
      );
    }
  }

  StreamSubscription<Either<AuthFailure, AuthEvent>>? _verifyStreamSubscription;

  /// Submit SMS code for validation completion [VerifyPhone]
  Stream<VerifyPhoneState> _mapVerifyPhoneToState(VerifyPhone e) async* {
    yield const VerifyPhoneState.awaitingVerification();

    _verifyStreamSubscription =
        _authFacade.verifyPhone(phoneNumber: e.phoneNumber).listen(
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
