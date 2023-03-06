part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  const factory AuthEvent.initial() = _InitialEvent;

  const factory AuthEvent.verifyPhone(String phoneNumber) = _VerifyPhone;

  const factory AuthEvent.updated(
    Either<AuthFailure, $auth_success.AuthSuccess> failureOrCredential,
  ) = _Updated;

  const factory AuthEvent.signInWithPhone(String smsCode) = _SignInWithPhone;

  const factory AuthEvent.resendCode() = _ResendCode;

  const factory AuthEvent.updateProfilePhoto(File photo) = _UpdateProfilePhoto;

  const factory AuthEvent.reset() = _Reset;

  /// Request for current auth state
  const factory AuthEvent.authCheckRequested() = _AuthCheckRequested;

  /// Sign out
  const factory AuthEvent.signedOut() = _SignedOut;

  @override
  List<Object?> get props => [];
}

class _InitialEvent extends AuthEvent {
  const _InitialEvent();
}

class _VerifyPhone extends AuthEvent {
  final String phoneNumber;

  const _VerifyPhone(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class _Updated extends AuthEvent {
  final Either<AuthFailure, $auth_success.AuthSuccess> failureOrCredential;

  const _Updated(this.failureOrCredential);

  @override
  List<Object?> get props => [failureOrCredential];
}

class _SignInWithPhone extends AuthEvent {
  final String smsCode;

  const _SignInWithPhone(this.smsCode);

  @override
  List<Object?> get props => [smsCode];
}

class _ResendCode extends AuthEvent {
  const _ResendCode();
}

class _UpdateProfilePhoto extends AuthEvent {
  final File photo;

  const _UpdateProfilePhoto(this.photo);

  @override
  List<Object?> get props => [photo];
}

class _Reset extends AuthEvent {
  const _Reset();
}

/// Request for current auth state
class _AuthCheckRequested extends AuthEvent {
  const _AuthCheckRequested();
}

/// Sign out
class _SignedOut extends AuthEvent {
  const _SignedOut();
}
