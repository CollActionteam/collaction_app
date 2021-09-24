import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/auth/i_auth_facade.dart';
import 'package:collaction_app/domain/auth/value_objects.dart';
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
      phoneChanged: (e) async* {
        yield state.copyWith(
            phoneNumber: PhoneNumber(e.phone),
            authFailureOrSuccessOption: none());
      },
      smsCodeChanged: (e) async* {
        yield state.copyWith(
            credential: state.credential.copyWith(smsCode: e.smsCode),
            authFailureOrSuccessOption: none());
      },
      verifyPhone: (e) async* {
        final isPhoneValid = state.phoneNumber.isValid();

        if (isPhoneValid) {
          yield state.copyWith(
            isSendingSms: true,
            authFailureOrSuccessOption: none(),
          );

          yield* _authFacade.verifyPhone(phoneNumber: state.phoneNumber).map(
                (failureOrCredential) => failureOrCredential.fold(
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
                ),
              );
        }else{
          // Invalid
          yield state.copyWith(
            isSendingSms: false,
            authFailureOrSuccessOption:
                optionOf(const AuthFailure.invalidPhone()),
          );
        }

      },
      signInWithPhone: (e) async* {
        yield state.copyWith(isSendingSmsSuccessful: false, isSigningIn: true);

        final authSuccessOrFailure = await _authFacade.signInWithPhone(
            authCredentials: state.credential.copyWith(smsCode: e.smsCode));

        yield authSuccessOrFailure.fold(
            (failure) => state.copyWith(
                isSigningIn: false,
                authFailureOrSuccessOption: optionOf(failure)),
            (_) => state.copyWith(
                isSigningIn: false,
                isSignInSuccessful: true,
                authFailureOrSuccessOption: none()));
      },
    );
  }
}
