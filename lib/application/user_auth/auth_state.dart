part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  /// No authentication ongoing
  const factory AuthState.initial() = _Initial;

  /// Authentication has been started, waiting for backend to respond
  const factory AuthState.registeringPhoneNumber() = _RegisteringPhoneNumber;

  /// An error has occured during authentication
  const factory AuthState.authError(Exception error) = _AuthError;

  /// Authentication may be completed with verification code
  const factory AuthState.awaitingVerification() = _AwaitingVerification;

  /// Authentication will be completed, waiting for backend to respond to verification
  const factory AuthState.verifying(String smsCode) = _Verifying;

  /// Authentication has been completed
  const factory AuthState.loggedIn({required bool isNewUser}) = _LoggedIn;
}
