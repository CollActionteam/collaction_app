part of 'verify_phone_bloc.dart';

@freezed
class VerifyPhoneEvent with _$VerifyPhoneEvent {
  const factory VerifyPhoneEvent.phoneChanged(String phone) = PhoneChanged;
  const factory VerifyPhoneEvent.smsCodeChanged(String smsCode) = SmsCodeChanged;
  const factory VerifyPhoneEvent.verifyPhone() = VerifyPhone;
}

