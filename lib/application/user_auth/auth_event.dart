part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  /// Start user registration
  const factory AuthEvent.registerPhoneNumber(String phoneNumber) =
      _RegisterPhoneNumber;

  /// An error occurred anywhere during the authentication process
  /// (This does not necessarily mean the authentication has been aborted)
  const factory AuthEvent.error(Exception error) = _Error;

  /// The app has received new credentials for authenticating the user
  const factory AuthEvent.updated(Credential credential) = _Updated;

  /// Complete user registration
  const factory AuthEvent.verify(String smsCode) = _Verify;

  /// The user has successfully logged in by verifying their phone number
  const factory AuthEvent.logIn({required bool isNewUser}) = _LogIn;

  /// The authentication has been aborted by the user
  const factory AuthEvent.reset() = _Reset;
}
