import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_success.freezed.dart';

@freezed
class AuthSuccess with _$AuthSuccess {
  const factory AuthSuccess.codeSent({required Credential credential}) =
      _SmsCodeSent;

  const factory AuthSuccess.codeRetrievalTimedOut(
      {required Credential credential}) = _CodeRetrievalTimedOut;

  const factory AuthSuccess.verificationCompleted(
      {required Credential credential}) = _VerificationCompleted;
}
