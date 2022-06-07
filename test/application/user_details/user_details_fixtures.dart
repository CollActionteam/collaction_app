import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';

import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

final IUserRepository tUserRepo = MockUserRepository();

// ignore: avoid_positional_boolean_parameters
Future<String?> testGetAnonymousTokenId([bool forceRefresh = false]) =>
    Future.value(null);

const User tUser = User(
  id: 'tId',
  getIdToken: testGetAnonymousTokenId,
);
