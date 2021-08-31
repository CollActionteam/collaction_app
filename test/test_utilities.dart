import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

// ignore: avoid_classes_with_only_static_members
class TestUtilities {
  static void mockUser(Stream<User> userStream) {
    final mockUserRepository = MockUserRepository();
    when(() => mockUserRepository.observeUser())
        .thenAnswer((_) => userStream);
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<IUserRepository>(mockUserRepository);
  }
}