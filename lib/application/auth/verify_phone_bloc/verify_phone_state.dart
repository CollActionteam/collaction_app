part of 'verify_phone_bloc.dart';

@freezed
class VerifyPhoneState with _$VerifyPhoneState {
  const factory VerifyPhoneState({
    required String phoneNumber,
    required String username,
    required bool isUpdatingUsername,
    required bool isUsernameUpdateSuccessful,
    required Credential credential,
    required bool isSigningIn,
    required bool isSignInSuccessful,
    required bool isVerifying,
    required bool isVerifySuccessful,
    required bool isSendingSms,
    required bool isSendingSmsSuccessful,
    required bool autoCompleteSms,
    required Option<AuthFailure> authFailureOrSuccessOption,
  }) = _VerifyPhoneState;

  factory VerifyPhoneState.initial() => VerifyPhoneState(
        phoneNumber: '',
        username: '',
        isUpdatingUsername: false,
        isUsernameUpdateSuccessful: false,
        credential: const Credential(),
        isSigningIn: false,
        isSignInSuccessful: false,
        isVerifying: false,
        isVerifySuccessful: false,
        isSendingSms: false,
        isSendingSmsSuccessful: false,
        autoCompleteSms: false,
        authFailureOrSuccessOption: none(),
      );
}
