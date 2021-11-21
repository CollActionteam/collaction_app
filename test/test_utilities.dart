import 'package:collaction_app/domain/contact_form/contact_form_contents.dart';
import 'package:collaction_app/domain/contact_form/i_contact_form_api.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockSettingsRepository extends Mock implements ISettingsRepository {}

class MockContactFormApi extends Mock implements IContactFormApi {}

// ignore: avoid_classes_with_only_static_members
class TestUtilities {
  static void mockUser(Stream<User> userStream) {
    final mockUserRepository = MockUserRepository();
    when(() => mockUserRepository.observeUser()).thenAnswer((_) => userStream);
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<IUserRepository>(mockUserRepository);
  }

  static void mockContactFormApi({required bool doesSubmissionSucceed}) {
    registerFallbackValue(ContactFormContents());
    final mockContactFormApi = MockContactFormApi();
    when(() => mockContactFormApi.sendContactFormContents(any()))
        .thenAnswer((_) async => doesSubmissionSucceed);
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<IContactFormApi>(mockContactFormApi);
  }
}
