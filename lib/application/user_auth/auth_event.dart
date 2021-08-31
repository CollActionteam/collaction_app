part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.registerPhoneNumber(String phoneNumber) =
      _RegisterPhoneNumber;
  const factory AuthEvent.error(Exception error) = _Error;
  const factory AuthEvent.updated(Credential credential) = _Updated;
  const factory AuthEvent.verify(String smsCode) = _Verify;
  const factory AuthEvent.logIn({required bool isNewUser}) = _LogIn;
  const factory AuthEvent.reset() = _Reset;
}
