part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  /// No authentication ongoing
  const factory AuthState.initial() = _Initial;

  /// Authentication has been started, waiting for backend to respond
  const factory AuthState.signingInUser() = SigningInUser;

  /// SMS Code has been sent, wait for autocomplete or user to enter code
  const factory AuthState.smsCodeSent() = _SmsCodeSent;

  /// SMS Code verification has been completed, sign in user with credentials
  const factory AuthState.verificationCompleted(String smsCode) =
      _VerificationCompleted;

  /// SMS Code autocomplete has timed out, allow user to resend code
  const factory AuthState.codeRetrievalTimedOut(Credential? credential) =
      _CodeRetrievalTimedOut;

  /// An error has occurred during authentication
  const factory AuthState.authError(AuthFailure failure) = _AuthError;

  /// Authentication may be completed with verification code
  const factory AuthState.awaitingVerification() = AwaitingVerification;

  /// Authentication will be completed, waiting for backend to respond to verification
  const factory AuthState.verifying(String smsCode) = _Verifying;

  /// Authentication has been completed
  const factory AuthState.loggedIn({required bool isNewUser}) = _LoggedIn;

  /// Code is being resent
  const factory AuthState.awaitingCodeResend() = AwaitingCodeResend;

  /// Username/Display name is being updated
  const factory AuthState.awaitingUsernameUpdate() = AwaitingUsernameUpdate;

  /// Username/Display update done
  const factory AuthState.usernameUpdateDone() = _UsernameUpdateDone;

  /// Profile Photo is being updated
  const factory AuthState.awaitingPhotoUpdate() = AwaitingProfilePhotoUpdate;

  /// Profile photo update done
  const factory AuthState.photoUpdateDone() = _ProfilePhotoUpdateDone;

  /// Splash Auth states
  const factory AuthState.authenticated(User user) = _Authenticated;

  const factory AuthState.unAuthenticated() = _UnAuthenticated;
}
