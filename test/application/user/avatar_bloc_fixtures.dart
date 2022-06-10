import 'dart:io';

import 'package:collaction_app/application/user/avatar/avatar_bloc.dart';
import 'package:collaction_app/infrastructure/user/avatar_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAvatarRepo extends Mock implements AvatarRepository {}

class MockAvatarFile extends Mock implements File {}

final avatarRepo = MockAvatarRepo();
final avatarRepo2 = MockAvatarRepo();
final tAvatarBloc = AvatarBloc(avatarRepo);
final tAvatarFile = MockAvatarFile();
final tUri = Uri.parse('testAvatarUploadUri');
