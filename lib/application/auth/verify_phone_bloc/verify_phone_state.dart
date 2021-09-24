part of 'verify_phone_bloc.dart';

@freezed
class VerifyPhoneState with _$VerifyPhoneState {
  const factory VerifyPhoneState({
    required PhoneNumber phoneNumber,
    required Credential credential,
    required bool isSigningIn,
    required bool isSignInSuccessful,
    required bool isVerifying,
    required bool isVerifySuccessful,
    required bool smsCodeSent,
    required bool autoCompleteSms,
    required Option<AuthFailure> authFailureOrSuccessOption,
  }) = _VerifyPhoneState;

  factory VerifyPhoneState.initial() => VerifyPhoneState(
        phoneNumber: PhoneNumber(''),
        credential: const Credential(),
        isSigningIn: false,
        isSignInSuccessful: false,
        isVerifying: false,
        isVerifySuccessful: false,
        smsCodeSent: false,
        autoCompleteSms: false,
        authFailureOrSuccessOption: none(),
      );
}
