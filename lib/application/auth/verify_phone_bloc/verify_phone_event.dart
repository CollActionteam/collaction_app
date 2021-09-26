part of 'verify_phone_bloc.dart';

@freezed
class VerifyPhoneEvent with _$VerifyPhoneEvent {

  const factory VerifyPhoneEvent.verifyPhone(String phoneNumber) = _VerifyPhone;

  const factory VerifyPhoneEvent.updated(
      Either<AuthFailure, AuthSuccess> failureOrCredential) = _Updated;

  const factory VerifyPhoneEvent.signInWithPhone(String smsCode) =
      _SignInWithPhone;

  const factory VerifyPhoneEvent.updateUsername(String username) =
      _UpdateUsername;

  const factory VerifyPhoneEvent.reset() = _Reset;
}

