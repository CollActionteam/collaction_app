part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  /// No authentication ongoing
  const factory AuthState.initial() = _Initial;

  /// Authentication has been started, waiting for backend to respond
  const factory AuthState.signingInUser() = SigningInUser;

  /// SMS Code has been sent, wait for autocomplete or user to enter code
  const factory AuthState.smsCodeSent() = SmsCodeSent;

  /// SMS Code verification has been completed, sign in user with credentials
  const factory AuthState.verificationCompleted(String smsCode) =
      VerificationCompleted;

  /// SMS Code autocomplete has timed out, allow user to resend code
  const factory AuthState.codeRetrievalTimedOut() = _CodeRetrievalTimedOut;

  /// An error has occurred during authentication
  const factory AuthState.authError(AuthFailure failure) = AuthError;

  /// Authentication may be completed with verification code
  const factory AuthState.awaitingVerification() = AwaitingVerification;

  /// Authentication will be completed, waiting for backend to respond to verification
  const factory AuthState.verifying(String smsCode) = _Verifying;

  /// Authentication has been completed
  const factory AuthState.loggedIn({required bool isNewUser}) = LoggedIn;

  /// Code is being resent
  const factory AuthState.awaitingCodeResend() = AwaitingCodeResend;

  /// Profile Photo is being updated
  const factory AuthState.awaitingPhotoUpdate() = AwaitingProfilePhotoUpdate;

  /// Profile photo update done
  const factory AuthState.photoUpdateDone() = ProfilePhotoUpdateDone;

  /// Splash Auth states
  const factory AuthState.authenticated(User user) = Authenticated;

  const factory AuthState.unauthenticated() = _UnAuthenticated;

  @override
  List<Object?> get props => [];
}

/// No authentication ongoing
class _Initial extends AuthState {
  const _Initial();
}

/// Authentication has been started, waiting for backend to respond
class SigningInUser extends AuthState {
  const SigningInUser();
}

/// SMS Code has been sent, wait for autocomplete or user to enter code
class SmsCodeSent extends AuthState {
  const SmsCodeSent();
}

/// SMS Code verification has been completed, sign in user with credentials
class VerificationCompleted extends AuthState {
  final String smsCode;

  const VerificationCompleted(this.smsCode);

  @override
  List<Object?> get props => [smsCode];
}

/// SMS Code autocomplete has timed out, allow user to resend code
class _CodeRetrievalTimedOut extends AuthState {
  const _CodeRetrievalTimedOut();
}

/// An error has occurred during authentication
class AuthError extends AuthState {
  final AuthFailure failure;

  const AuthError(this.failure);

  @override
  List<Object?> get props => [failure];
}

/// Authentication may be completed with verification code
class AwaitingVerification extends AuthState {
  const AwaitingVerification();
}

/// Authentication will be completed, waiting for backend to respond to verification
class _Verifying extends AuthState {
  final String smsCode;

  const _Verifying(this.smsCode);

  @override
  List<Object?> get props => [smsCode];
}

/// Authentication has been completed
class LoggedIn extends AuthState {
  final bool isNewUser;

  const LoggedIn({required this.isNewUser});

  @override
  List<Object?> get props => [isNewUser];
}

/// Code is being resent
class AwaitingCodeResend extends AuthState {
  const AwaitingCodeResend();
}

/// Profile Photo is being updated
class AwaitingProfilePhotoUpdate extends AuthState {
  const AwaitingProfilePhotoUpdate();
}

/// Profile photo update done
class ProfilePhotoUpdateDone extends AuthState {
  const ProfilePhotoUpdateDone();
}

/// Splash Auth states
class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class _UnAuthenticated extends AuthState {
  const _UnAuthenticated();
}
