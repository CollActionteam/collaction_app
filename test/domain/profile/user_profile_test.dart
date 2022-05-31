import 'package:collaction_app/domain/profile/user_profile.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

import 'profile_fixture.dart';

void main() {
  group('Tests covering UserProfile', () {
    Future<String?> _getAnonymousIdToken([bool forceRefresh = false]) =>
        Future.value(null);
    const cAnonUser = User.anonymous;
    final cUser = User(id: 'test', getIdToken: _getAnonymousIdToken);
    final cUserProfile = UserProfile(user: cUser, profile: cProfileFromJson);
    const cAnonymousProfile =
        UserProfile(user: cAnonUser, profile: cProfileFromJson);
    final cUserJoinDate = User(
      id: 'test',
      joinDate: DateTime(2022, 12),
      getIdToken: _getAnonymousIdToken,
    );

    test('Test non-anonymous UserProfile', () {
      final tUserProfile = UserProfile(
        user: User(id: 'test', getIdToken: _getAnonymousIdToken),
        profile: cProfileFromJson,
      );

      expect(tUserProfile, cUserProfile);
    });

    test('Test Anonymous UserProfile', () {
      const tUserProfile =
          UserProfile(user: cAnonUser, profile: cProfileFromJson);

      expect(tUserProfile, cAnonymousProfile);
    });

    test('Test isAnonymous', () {
      expect(cUser.isAnonymous, false);
      expect(cAnonUser.isAnonymous, true);
    });

    test('Test formattedJoinDate', () {
      expect(cUserJoinDate.formattedJoinDate, 'December 2022');
    });

    test('Test default values', () {
      final tUser = User(id: 'test', getIdToken: _getAnonymousIdToken);

      expect(tUser.isEmailVerified, false);
      expect(tUser.isPhoneNumberVerified, false);
    });
  });
}
