import 'package:equatable/equatable.dart';

import '../user/i_user_repository.dart';

abstract class AuthSuccess extends Equatable {
  final Credential credential;

  const AuthSuccess({required this.credential});

  const factory AuthSuccess.codeSent({required Credential credential}) =
      SmsCodeSent;

  const factory AuthSuccess.codeRetrievalTimedOut({
    required Credential credential,
  }) = CodeRetrievalTimedOut;

  const factory AuthSuccess.verificationCompleted({
    required Credential credential,
  }) = VerificationCompleted;

  @override
  List<Object?> get props => [credential];
}

class SmsCodeSent extends AuthSuccess {
  const SmsCodeSent({required super.credential});
}

class CodeRetrievalTimedOut extends AuthSuccess {
  const CodeRetrievalTimedOut({required super.credential});
}

class VerificationCompleted extends AuthSuccess {
  const VerificationCompleted({required super.credential});
}
