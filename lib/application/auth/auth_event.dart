part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.verifyPhone(String phoneNumber) = _VerifyPhone;

  const factory AuthEvent.updated(
      Either<AuthFailure, AuthSuccess> failureOrCredential) = _Updated;

  const factory AuthEvent.signInWithPhone(String smsCode) = _SignInWithPhone;

  const factory AuthEvent.resendCode() = _ResendCode;

  const factory AuthEvent.updateUsername(String username) = _UpdateUsername;

  const factory AuthEvent.updateProfilePhoto(File photo) = _UpdateProfilePhoto;

  const factory AuthEvent.reset() = _Reset;

  /// Request for current auth state
  const factory AuthEvent.authCheckRequested() = _AuthCheckRequested;

  /// Sign out
  const factory AuthEvent.signedOut() = _SignedOut;
}

