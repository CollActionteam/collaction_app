part of 'verify_phone_bloc.dart';

@freezed
class VerifyPhoneEvent with _$VerifyPhoneEvent {
  const factory VerifyPhoneEvent.phoneChanged(String phone) = PhoneChanged;
  const factory VerifyPhoneEvent.smsCodeChanged(String smsCode) = CodeChanged;
  const factory VerifyPhoneEvent.verifyPhone() = VerifyPhone;
  const factory VerifyPhoneEvent.signInWithPhone() = SignInWithPhone;
}

