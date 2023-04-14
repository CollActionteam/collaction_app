import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/infrastructure/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class CustomMockFirebaseAuth extends Mock
    implements firebase_auth.FirebaseAuth {}

class CustomMockUserCredential extends Mock
    implements firebase_auth.UserCredential {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      const firebase_auth.AuthCredential(
        signInMethod: 'mock',
        providerId: 'mock',
      ),
    );
  });

  group('User Repository Tests:', () {
    test(
      'New user (anonymous)',
      () async {
        // ignore: avoid_redundant_argument_values
        final mockFirebaseAuth = MockFirebaseAuth(signedIn: false);
        final userRepository = UserRepository(firebaseAuth: mockFirebaseAuth);
        final user = await userRepository.observeUser().first;
        expect(user, User.anonymous);
        expect(user.isAnonymous, true);
      },
      timeout: const Timeout(Duration(seconds: 5)),
    );

    test(
      'Returning user',
      () async {
        // ignore: avoid_redundant_argument_values
        final mockFirebaseAuth = MockFirebaseAuth(signedIn: true);
        final userRepository = UserRepository(firebaseAuth: mockFirebaseAuth);
        final user = await userRepository.observeUser().skip(1).first;
        expect(user, isNot(User.anonymous));
        expect(user.isAnonymous, false);
      },
      timeout: const Timeout(Duration(seconds: 5)),
    );

    Future<void> testRegistration({required bool isNewUser}) async {
      final mockFirebaseAuth = CustomMockFirebaseAuth();
      final mockUserCredential = CustomMockUserCredential();
      when(() => mockFirebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) => Future.value(mockUserCredential));
      when(() => mockFirebaseAuth.authStateChanges())
          .thenAnswer((_) => const Stream.empty());
      when(() => mockUserCredential.additionalUserInfo)
          .thenReturn(firebase_auth.AdditionalUserInfo(isNewUser: isNewUser));
      final userRepository = UserRepository(firebaseAuth: mockFirebaseAuth);
      // First part of registration cannot be meaningfully tested using mock
      final signInResult = await userRepository.signIn(
        const Credential(
          verificationId: 'someVerificationId',
          smsCode: 'someSmsCode',
        ),
      );
      expect(signInResult.isNewUser, isNewUser);
    }

    test('Register with phone number', () async {
      await testRegistration(isNewUser: true);
    });

    test('Log in with phone number', () async {
      await testRegistration(isNewUser: false);
    });
  });
}
