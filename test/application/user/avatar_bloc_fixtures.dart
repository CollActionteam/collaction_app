import 'package:collaction_app/application/user/avatar/avatar_bloc.dart';

import '../../test_utilities.dart';

final avatarRepo = MockAvatarRepository();
final avatarRepo2 = MockAvatarRepository();
final tAvatarBloc = AvatarBloc(avatarRepo);
final tAvatarFile = MockAvatarFile();
final tUri = Uri.parse('testAvatarUploadUri');
