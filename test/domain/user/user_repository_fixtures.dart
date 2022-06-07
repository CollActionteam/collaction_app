import 'package:collaction_app/domain/user/i_user_repository.dart';

const tCredentials = Credential(
  forceResendToken: 123,
  smsCode: '123456',
  verificationId: 'thisIsTheVerificationIdForTheTest',
);

final tSignInResult = SignInResult(isNewUser: false);

final tAuthException = AuthException();
final tException = AuthException(message: 'This is an exception');
