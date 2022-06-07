import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'user_repository_fixtures.dart';

void main() {
  group('Testing Credential methods', () {
    test('Testing credential props getter', () {
      expect(
        tCredentials.props,
        ['thisIsTheVerificationIdForTheTest', '123456', 123],
      );
    });

    test('Testing Credential.copyWith method', () {
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

  group('Testing SignIn class', () {
    test('SignIn initializer', () {
      expect(tSignInResult.isNewUser, false);
    });
  });

  group('Testing AuthException class', () {
    test('Testing default AuthException message', () {
      expect(tAuthException.toString(), 'AuthException');
      expect(tException.toString(), 'This is an exception');
    });
  });
}
