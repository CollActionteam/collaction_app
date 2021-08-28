import 'package:collaction_app/domain/user/user.dart';

class Credential {
  final String? verificationId, smsCode;

  Credential(this.verificationId, this.smsCode);
}

class SignInResult {
  final bool isNewUser;

  SignInResult({required this.isNewUser});
}

abstract class IUserRepository {
  Stream<User> observeUser();

  /// Returns a stream of [Credential] instances to be used with [signIn].
  /// Incomplete credentials must be completed with information provided by the user.
  Stream<Credential> registerPhoneNumber(String phoneNumber);

  Future<SignInResult> signIn(Credential credential);
}
