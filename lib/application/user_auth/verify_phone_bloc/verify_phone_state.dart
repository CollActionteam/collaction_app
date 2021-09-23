part of 'verify_phone_bloc.dart';

@freezed
class VerifyPhoneState with _$VerifyPhoneState {
  const factory VerifyPhoneState({
    required PhoneNumber phoneNumber,
    required String smsCode,
    required bool isVerifying,
    required bool verifyingDone,
    required Option<AuthFailure> authFailureOrSuccessOption,
  }) = _VerifyPhoneState;

  factory VerifyPhoneState.initial() => VerifyPhoneState(
        phoneNumber: PhoneNumber(''),
        smsCode: '',
        isVerifying: false,
        verifyingDone: false,
        authFailureOrSuccessOption: none(),
      );
}
