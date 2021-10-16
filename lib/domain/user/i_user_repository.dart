import 'package:equatable/equatable.dart';

import 'user.dart';

class Credential extends Equatable {
  final String? verificationId;
  final String? smsCode;
  final int? forceResendToken;

  const Credential({this.verificationId, this.smsCode, this.forceResendToken});

  @override
  List<Object?> get props => [verificationId, smsCode, forceResendToken];

  Credential copyWith(
      {String? verificationId, String? smsCode, int? forceResendToken}) {
    return Credential(
        verificationId: verificationId ?? this.verificationId,
        smsCode: smsCode ?? this.smsCode,
        forceResendToken: forceResendToken ?? this.forceResendToken);
  }
}

class SignInResult {
  final bool isNewUser;

  SignInResult({required this.isNewUser});
}

class AuthException implements Exception {
  final String? message;

  AuthException({this.message});

  @override
  String toString() {
    return message ?? 'AuthException';
  }
}

abstract class IUserRepository {
  Stream<User> observeUser();

  /// Returns a stream of [Credential] instances to be used with [signIn].
  /// Incomplete credentials must be completed with information provided by the user.
  Stream<Credential> registerPhoneNumber(String phoneNumber);

  Future<SignInResult> signIn(Credential credential);
}
