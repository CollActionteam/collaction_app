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

  Stream<User> observeCurrentUser();

  Stream<Credential> registerPhoneNumber(String phoneNumber);

  Future<SignInResult> signIn(Credential credential);
}