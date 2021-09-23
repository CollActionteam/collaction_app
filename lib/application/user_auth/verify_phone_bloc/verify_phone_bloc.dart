import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/auth/i_auth_facade.dart';
import 'package:collaction_app/domain/auth/value_objects.dart';
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
            smsCode: e.smsCode, authFailureOrSuccessOption: none());
      },
      verifyPhone: (e) async* {

        final isPhoneValid = state.phoneNumber.isValid();

        if (isPhoneValid) {
          yield state.copyWith(
            isVerifying: true,
            authFailureOrSuccessOption: none(),
          );

          yield* _authFacade.verifyPhone(phoneNumber: state.phoneNumber).map(
                (failureOrCredential) => failureOrCredential.fold(
                  (failure) => state.copyWith(
                    isVerifying: false,
                    authFailureOrSuccessOption: some(failure),
                  ),
                  (r) => state.copyWith(
                    isVerifying: false,
                    verifyingDone: true,
                  ),
                ),
              );
        }

        // Invalid
        yield state.copyWith(
          isVerifying: false,
          authFailureOrSuccessOption: optionOf(const AuthFailure.invalidPhone()),
        );
      },
    );
  }
}
