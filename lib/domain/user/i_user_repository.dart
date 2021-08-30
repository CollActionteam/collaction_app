import 'package:collaction_app/domain/user/user.dart';
import 'package:equatable/equatable.dart';

class Credential extends Equatable {
  final String? verificationId, smsCode;

  const Credential(this.verificationId, this.smsCode);

  @override
  List<Object?> get props => [verificationId, smsCode];
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
