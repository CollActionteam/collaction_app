part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.registeringPhoneNumber() = _RegisteringPhoneNumber;
  const factory AuthState.authError(Exception error) = _AuthError;
  const factory AuthState.awaitingVerification() = _AwaitingVerification;
  const factory AuthState.verifying(String smsCode) = _Verifying;
  const factory AuthState.loggedIn({required bool isNewUser}) = _LoggedIn;
}
