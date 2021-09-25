part of 'verify_phone_bloc.dart';

@freezed
class VerifyPhoneEvent with _$VerifyPhoneEvent {
  // const factory VerifyPhoneEvent.phoneChanged(String phone) = PhoneChanged;

  // const factory VerifyPhoneEvent.smsCodeChanged(String smsCode) = CodeChanged;

  const factory VerifyPhoneEvent.verifyPhone(String phoneNumber) = VerifyPhone;

  const factory VerifyPhoneEvent.updated(
      Either<AuthFailure, AuthEvent> failureOrCredential) = Updated;

  const factory VerifyPhoneEvent.signInWithPhone(String smsCode) =
      SignInWithPhone;

  // const factory VerifyPhoneEvent.usernameChanged(String username) =
  //     UsernameChanged;

  const factory VerifyPhoneEvent.updateUsername(String username) =
      UpdateUsername;
}

