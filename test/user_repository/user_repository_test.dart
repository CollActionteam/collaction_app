import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/infrastructure/user/user_repository.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('User Repository Tests:', () {
    test('New user (anonymous)', () async {
      // ignore: avoid_redundant_argument_values
      final mockFirebaseAuth = MockFirebaseAuth(signedIn: false);
      final _userRepository = UserRepository(firebaseAuth: mockFirebaseAuth);
      final user = await _userRepository.observeUser().first;
      expect(user, User.anonymous);
      expect(user.isAnonymous, true);
    }, timeout: const Timeout(Duration(seconds: 5)));

    test('Returning user', () async {
      // ignore: avoid_redundant_argument_values
      final mockFirebaseAuth = MockFirebaseAuth(signedIn: true);
      final _userRepository = UserRepository(firebaseAuth: mockFirebaseAuth);
      final user = await _userRepository.observeUser().skip(1).first;
      expect(user, isNot(User.anonymous));
      expect(user.isAnonymous, false);
    }, timeout: const Timeout(Duration(seconds: 5)));
  });
}
