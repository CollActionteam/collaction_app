import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'user_repository_fixtures.dart';

void main() {
  group('testing Credential methods', () {
    test('testing credential props getter', () {
      expect(
        tCredentials.props,
        ['thisIsTheVerificationIdForTheTest', '123456', 123],
      );
    });

    test('testing Credential.copyWith method', () {
      Credential cCreds = tCredentials.copyWith(forceResendToken: 469);
      expect(cCreds.forceResendToken, 469);
      expect(cCreds.smsCode, '123456');
      expect(cCreds.verificationId, 'thisIsTheVerificationIdForTheTest');
      cCreds = cCreds.copyWith(smsCode: '258963');
      cCreds = cCreds.copyWith(verificationId: 'iDontKnowWhyAmIWritingThis');
      expect(cCreds.smsCode, '258963');
      expect(cCreds.verificationId, 'iDontKnowWhyAmIWritingThis');
    });
  });

  group('testing SignIn class', () {
    test('SignIn initializer', () {
      expect(tSignInResult.isNewUser, false);
    });
  });

  group('testing AuthException class', () {
    test('testing default AuthException message', () {
      expect(tAuthException.toString(), 'AuthException');
      expect(tException.toString(), 'This is an exception');
    });
  });
}
