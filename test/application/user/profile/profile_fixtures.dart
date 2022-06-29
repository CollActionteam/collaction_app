import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/domain/profile/profile.dart';
import 'package:collaction_app/domain/profile/user_profile.dart';
import 'package:collaction_app/domain/user/user.dart';

import '../../../test_utilities.dart';

final tProfileRepository = MockProfileRepository();
final tAvatarRepository = MockAvatarRepository();
const tUser = User(id: 'tId', getIdToken: getAnonymousIdToken);
const tProfile = Profile(bio: 'tBio');
const tUserProfile = UserProfile(user: tUser, profile: tProfile);
final tProfileBloc = ProfileBloc(tProfileRepository, tAvatarRepository);
