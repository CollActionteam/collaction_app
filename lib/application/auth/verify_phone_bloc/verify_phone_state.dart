part of 'verify_phone_bloc.dart';

@freezed
class VerifyPhoneState with _$VerifyPhoneState {
  /// No authentication ongoing
  const factory VerifyPhoneState.initial() = _Initial;

  /// Authentication has been started, waiting for backend to respond
  const factory VerifyPhoneState.signingInUser() = SigningInUser;

  /// SMS Code has been sent, wait for autocomplete or user to enter code
  const factory VerifyPhoneState.smsCodeSent() = _SmsCodeSent;

  /// SMS Code verification has been completed, sign in user with credentials
  const factory VerifyPhoneState.verificationCompleted(String smsCode) =
      _VerificationCompleted;

  /// SMS Code autocomplete has timed out, allow user to resend code
  const factory VerifyPhoneState.codeRetrievalTimedOut() =
      _CodeRetrievalTimedOut;

  /// An error has occurred during authentication
  const factory VerifyPhoneState.authError(AuthFailure failure) = _AuthError;

  /// Authentication may be completed with verification code
  const factory VerifyPhoneState.awaitingVerification() = AwaitingVerification;

  /// Authentication will be completed, waiting for backend to respond to verification
  const factory VerifyPhoneState.verifying(String smsCode) = _Verifying;

  /// Authentication has been completed
  const factory VerifyPhoneState.loggedIn({required bool isNewUser}) =
      _LoggedIn;

  /// Username/Display name is being updated
  const factory VerifyPhoneState.awaitingUsernameUpdate() =
      AwaitingUsernameUpdate;

  /// Username/Display update done
  const factory VerifyPhoneState.usernameUpdateDone() = _UsernameUpdateDone;
}
