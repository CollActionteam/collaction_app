import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.codeSent({required Credential credential}) = _SmsCodeSent;
  const factory AuthEvent.codeRetrievalTimedOut({required Credential credential}) = _CodeRetrievalTimedOut;
  const factory AuthEvent.verificationCompleted({ required Credential credential}) = _VerificationCompleted;
}
