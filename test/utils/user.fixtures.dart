import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/domain/profile/user_profile.dart';
import 'package:collaction_app/domain/user/user.dart';

/// Reusable user objects
// ignore: avoid_types_as_parameter_names
Future<String?> _getUserIdToken([bool]) async {
  return 'tokenId';
}

const testUser = User(id: 'id', getIdToken: _getUserIdToken);

final testProfile = Profile(
  userId: testUser.id,
  firstName: 'John',
  lastName: 'Doe',
  avatar: 'profiles/${testUser.id}.png',
);

final testUserProfile = UserProfile(user: testUser, profile: testProfile);
