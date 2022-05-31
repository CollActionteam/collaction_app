import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/domain/profile/user_profile.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('testing User Profile DTO', () async {
    Future<String?> _getAnonymousIdToken([bool forceRefresh = false]) =>
        Future.value(null);
    final tUser = User(id: 'test', getIdToken: _getAnonymousIdToken);
    final tUserProfile =
        UserProfile(user: tUser, profile: const Profile(bio: 'test'));

    expect(
      UserProfile(
        user: User(id: 'test', getIdToken: _getAnonymousIdToken),
        profile: const Profile(bio: 'test'),
      ),
      tUserProfile,
    );
  });
}
