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

  VerifyPhoneBloc(this._authFacade) : super(VerifyPhoneState.initial());

  @override
  Stream<VerifyPhoneState> mapEventToState(
    VerifyPhoneEvent event,
  ) async* {
    yield* event.map(
      phoneChanged: _phoneChanged,
      smsCodeChanged: _smsCodeChanged,
      verifyPhone: _verifyPhone,
      signInWithPhone: _signInWithPhone,
      updateUsername: _updateUsername,
      usernameChanged: _usernameChanged,
      updated: _mapUpdatedToState,
    );
  }

  Stream<VerifyPhoneState> _mapUpdatedToState(Updated value) async* {
    yield value.failureOrCredential.fold(
      (failure) => state.copyWith(
        isSendingSms: false,
        authFailureOrSuccessOption: some(failure),
      ),
      (r) {
        return r.map(
          codeSent: (e) => state.copyWith(
            credential: e.credential,
            isSendingSmsSuccessful: true,
            authFailureOrSuccessOption: none(),
          ),
          codeRetrievalTimedOut: (_) => state,
          verificationCompleted: (e) => state.copyWith(
            credential: e.credential,
            autoCompleteSms: e.credential.smsCode != null,
            isVerifySuccessful: true,
            authFailureOrSuccessOption: none(),
          ),
        );
      },
    );
  }

  /// Update username in user profile [UpdateUsername]
  Stream<VerifyPhoneState> _updateUsername(UpdateUsername e) async* {
    yield VerifyPhoneState.initial().copyWith(
      isUpdatingUsername: true,
      username: state.username,
    );

    final failureOrSuccess =
        await _authFacade.updateUsername(username: state.username);

    yield failureOrSuccess.fold(
      (failure) => state.copyWith(
        isUpdatingUsername: false,
        authFailureOrSuccessOption: optionOf(failure),
      ),
      (_) => state.copyWith(
        isUpdatingUsername: false,
        isUsernameUpdateSuccessful: true,
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  /// Handle username change [UsernameChanged]
  Stream<VerifyPhoneState> _usernameChanged(UsernameChanged e) async* {
    yield state.copyWith(
      username: e.username,
      authFailureOrSuccessOption: none(),
    );
  }

  /// Handle verification phone number change [PhoneChanged]
  Stream<VerifyPhoneState> _phoneChanged(PhoneChanged e) async* {
    yield state.copyWith(
      phoneNumber: e.phone,
      authFailureOrSuccessOption: none(),
    );
  }

  /// Handle SMS code change [CodeChanged]
  Stream<VerifyPhoneState> _smsCodeChanged(CodeChanged e) async* {
    yield state.copyWith(
      credential: state.credential.copyWith(smsCode: e.smsCode),
      authFailureOrSuccessOption: none(),
    );
  }

  /// Submit phone for validation [SignInWithPhone]
  Stream<VerifyPhoneState> _signInWithPhone(SignInWithPhone e) async* {
    yield VerifyPhoneState.initial().copyWith(
      isSendingSmsSuccessful: false,
      isSigningIn: true,
      credential: state.credential,
      authFailureOrSuccessOption: none(),
    );

    final authSuccessOrFailure = await _authFacade.signInWithPhone(
      authCredentials: state.credential.copyWith(smsCode: e.smsCode),
    );

    yield authSuccessOrFailure.fold(
      (failure) => state.copyWith(
        isSigningIn: false,
        authFailureOrSuccessOption: optionOf(failure),
      ),
      (_) => state.copyWith(
        isSigningIn: false,
        isSignInSuccessful: true,
        authFailureOrSuccessOption: none(),
      ),
    );
  }

  StreamSubscription<Either<AuthFailure, AuthEvent>>? _verifyStreamSubscription;

  /// Submit SMS code for validation completion [VerifyPhone]
  Stream<VerifyPhoneState> _verifyPhone(VerifyPhone e) async* {
    yield VerifyPhoneState.initial().copyWith(
      isSendingSms: true,
      authFailureOrSuccessOption: none(),
    );

    _verifyStreamSubscription = _authFacade
        .verifyPhone(phoneNumber: state.phoneNumber)
        .listen((failureOrCredential) =>
            add(VerifyPhoneEvent.updated(failureOrCredential)));
  }

  @override
  Future<void> close() async {
    _verifyStreamSubscription?.cancel();
    super.close();
  }
}
