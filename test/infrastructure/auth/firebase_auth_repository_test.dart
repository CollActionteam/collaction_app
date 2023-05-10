import 'package:collaction_app/domain/auth/auth_success.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/user/user.dart';

import 'package:collaction_app/infrastructure/auth/firebase_auth_repository.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CustomMockFirebaseAuth extends Mock
    implements firebase_auth.FirebaseAuth {}

class FirebaseAuthSetup {
  late MockUser mockFirebaseUser;
  late firebase_auth.FirebaseAuth mockFirebaseAuth;
  FirebaseAuthSetup({bool signedIn = true}) {
    mockFirebaseUser = MockUser();
    mockFirebaseAuth = signedIn
        ? MockFirebaseAuth(signedIn: true, mockUser: mockFirebaseUser)
        : MockFirebaseAuth();
  }
}

class CustomFirebaseAuthSetup {
  late firebase_auth.FirebaseAuth mockFirebaseAuth;
  late When mockVerifyPhoneNumber;
  CustomFirebaseAuthSetup() {
    mockFirebaseAuth = CustomMockFirebaseAuth();

    when(() => mockFirebaseAuth.authStateChanges())
        .thenAnswer((_) => const Stream.empty());

    mockVerifyPhoneNumber = when(() => mockFirebaseAuth.verifyPhoneNumber(
        phoneNumber: any(named: 'phoneNumber'),
        verificationCompleted: any(named: 'verificationCompleted'),
        verificationFailed: any(named: 'verificationFailed'),
        codeSent: any(named: 'codeSent'),
        codeAutoRetrievalTimeout: any(named: 'codeAutoRetrievalTimeout')));
  }
}

void main() {
  group('testing getSignedInUser: ', () {
    test("signed in user exists", () async {
      // mock
      FirebaseAuthSetup mocks = FirebaseAuthSetup(signedIn: true);

      IAuthRepository firebaseAuthRepository =
          FirebaseAuthRepository(firebaseAuth: mocks.mockFirebaseAuth);

      // perform test
      var result = await firebaseAuthRepository.getSignedInUser();
      var user = result.getOrElse(() => User.anonymous);

      // verify
      expect(user.id, equals(mocks.mockFirebaseUser.uid));
    });

    test("no signed in user", () async {
      // mock
      FirebaseAuthSetup mocks = FirebaseAuthSetup(signedIn: false);
      IAuthRepository firebaseAuthRepository =
          FirebaseAuthRepository(firebaseAuth: mocks.mockFirebaseAuth);

      // perform test
      var result = await firebaseAuthRepository.getSignedInUser();
      var user = result.getOrElse(() => User.anonymous);

      // verify
      expect(user, equals(User.anonymous));
    });
  });

  test("testing signOut -- remove user reference", () async {
    // mock
    FirebaseAuthSetup mocks = FirebaseAuthSetup(signedIn: true);
    firebase_auth.FirebaseAuth mockFirebaseAuth = mocks.mockFirebaseAuth;
    IAuthRepository firebaseAuthRepository =
        FirebaseAuthRepository(firebaseAuth: mockFirebaseAuth);

    // perform test
    expect(mockFirebaseAuth.currentUser, equals(mocks.mockFirebaseUser));
    await firebaseAuthRepository.signOut();

    // verify
    expect(mockFirebaseAuth.currentUser, isNull);
  });

  group('testing verifyPhone function: ', () {
    test('codeSent callback', () async {
      // mock
      CustomFirebaseAuthSetup mocks = CustomFirebaseAuthSetup();
      mocks.mockVerifyPhoneNumber.thenAnswer((invocation) async {
        Function codeSent = invocation.namedArguments[Symbol('codeSent')];
        await codeSent("verify id", 123);
      });

      IAuthRepository firebaseAuthRepository =
          FirebaseAuthRepository(firebaseAuth: mocks.mockFirebaseAuth);

      // perform test
      Stream result = firebaseAuthRepository.verifyPhone(phoneNumber: '');

      // verify
      result.listen(expectAsync1((value) {
        Credential cred = (value.value as AuthSuccess).credential;
        Credential expected =
            Credential(verificationId: "verify id", forceResendToken: 123);
        expect(cred == expected, true);
      }, count: 1));
    });

    /// TODO: Fix test failing as a result of using FirebaseCrashlytics
    ///  for logging which requires a firbase app instance
    // test('verificationFailed callback', () async {
    //   CustomFirebaseAuthSetup mocks = CustomFirebaseAuthSetup();
    //   mocks.mockVerifyPhoneNumber.thenAnswer((invocation) async {
    //     Function verificationFailed =
    //         invocation.namedArguments[Symbol('verificationFailed')];
    //     await verificationFailed(
    //         firebase_auth.FirebaseAuthException(code: 'unknown-server-error'));
    //   });

    //   IAuthRepository firebaseAuthRepository = FirebaseAuthRepository(
    //     firebaseAuth: mocks.mockFirebaseAuth,
    //   );

    //   // perform test
    //   Stream result = firebaseAuthRepository.verifyPhone(phoneNumber: '');

    //   // verify
    //   result.listen(expectAsync1((value) {
    //     AuthFailure failure = value.value;
    //     expect(failure == ServerError(), true);
    //   }, count: 1));
    // });

    test('codeAutoRetrievalTimeout callback', () async {
      // mock
      CustomFirebaseAuthSetup mocks = CustomFirebaseAuthSetup();
      mocks.mockVerifyPhoneNumber.thenAnswer((invocation) async {
        Function codeAutoRetrievalTimeout =
            invocation.namedArguments[Symbol('codeAutoRetrievalTimeout')];
        await codeAutoRetrievalTimeout("verify id");
      });

      IAuthRepository firebaseAuthRepository =
          FirebaseAuthRepository(firebaseAuth: mocks.mockFirebaseAuth);

      // perform test
      Stream result = firebaseAuthRepository.verifyPhone(phoneNumber: '');

      // verify
      result.listen(expectAsync1((value) {
        Credential cred = (value.value as AuthSuccess).credential;
        Credential expected = Credential(verificationId: "verify id");
        expect(cred == expected, true);
      }, count: 1));
    });

    test('verificationCompleted callback', () async {
      // mock
      CustomFirebaseAuthSetup mocks = CustomFirebaseAuthSetup();
      mocks.mockVerifyPhoneNumber.thenAnswer((invocation) async {
        Function verificationCompleted =
            invocation.namedArguments[Symbol('verificationCompleted')];

        await verificationCompleted(firebase_auth.PhoneAuthProvider.credential(
            verificationId: 'verify id', smsCode: 'code'));
      });

      IAuthRepository firebaseAuthRepository =
          FirebaseAuthRepository(firebaseAuth: mocks.mockFirebaseAuth);

      // perform test
      Stream result = firebaseAuthRepository.verifyPhone(phoneNumber: '');

      // verify
      result.listen(expectAsync1((value) {
        Credential cred = (value.value as AuthSuccess).credential;
        Credential expected =
            Credential(verificationId: "verify id", smsCode: 'code');
        expect(cred == expected, true);
      }, count: 1));
    });
  });
}
