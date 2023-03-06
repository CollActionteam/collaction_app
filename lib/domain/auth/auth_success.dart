import 'package:equatable/equatable.dart';

import '../user/i_user_repository.dart';

abstract class AuthSuccess extends Equatable {
  final Credential credential;

  const AuthSuccess({required this.credential});

  const factory AuthSuccess.codeSent({required Credential credential}) =
      _SmsCodeSent;

  const factory AuthSuccess.codeRetrievalTimedOut({
    required Credential credential,
  }) = _CodeRetrievalTimedOut;

  const factory AuthSuccess.verificationCompleted({
    required Credential credential,
  }) = _VerificationCompleted;

  @override
  List<Object?> get props => [credential];
}

class _SmsCodeSent extends AuthSuccess {
  const _SmsCodeSent({required super.credential});
}

class _CodeRetrievalTimedOut extends AuthSuccess {
  const _CodeRetrievalTimedOut({required super.credential});
}

class _VerificationCompleted extends AuthSuccess {
  const _VerificationCompleted({required super.credential});
}
