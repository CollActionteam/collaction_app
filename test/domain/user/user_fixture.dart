import 'package:collaction_app/domain/profile/user_profile.dart';
import 'package:collaction_app/domain/user/user.dart';

import '../profile/profile_fixture.dart';

const cAuthToken = 'token';

Future<String?> _getAnonymousIdToken([bool forceRefresh = false]) =>
    Future.value(cAuthToken);
const cAnonUser = User.anonymous;
const cUser = User(id: 'test', getIdToken: _getAnonymousIdToken);
const cUserProfile = UserProfile(user: cUser, profile: cProfileFromJson);
const cAnonymousProfile =
    UserProfile(user: cAnonUser, profile: cProfileFromJson);
final cUserJoinDate = User(
  id: 'test',
  joinDate: DateTime(2022, 12),
  getIdToken: _getAnonymousIdToken,
);
