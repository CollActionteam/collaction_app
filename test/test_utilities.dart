import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/contact_form/contact_form_dto.dart';
import 'package:collaction_app/domain/contact_form/i_contact_form_api.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_status.dart';
import 'package:collaction_app/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/crowdactions.dart';

class MockCrowdActionRepository extends Mock implements ICrowdActionRepository {
}

class MockAuthRepository extends Mock implements IAuthRepository {}

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
    registerFallbackValue(ContactFormDto(email: '', message: ''));
    final mockContactFormApi = MockContactFormApi();
    when(() => mockContactFormApi.sendContactFormContents(any()))
        .thenAnswer((_) async => doesSubmissionSucceed);
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<IContactFormApi>(mockContactFormApi);
  }

  static void mockCrowdActionApi() {
    registerFallbackValue(crowdActions.first.toDomain());

    final crowdActionRepo = MockCrowdActionRepository();

    when(() => crowdActionRepo.getCrowdActions()).thenAnswer(
      (_) async => right(crowdActions.map((u) => u.toDomain()).toList()),
    );

    when(() => crowdActionRepo.getSpotlightCrowdActions()).thenAnswer(
      (_) async => right(crowdActions.map((u) => u.toDomain()).toList()),
    );

    when(() => crowdActionRepo.subscribeToCrowdAction(any(), any(), any()))
        .thenAnswer((_) async => right(unit));

    when(() => crowdActionRepo.unsubscribeFromCrowdAction(any()))
        .thenAnswer((_) async => right(unit));

    when(() => crowdActionRepo.checkCrowdActionSubscriptionStatus(any()))
        .thenAnswer(
      (_) async => right(
        CrowdActionStatus.subscribed(
          crowdActions.first.commitment_options.map((e) => e.id).toList(),
        ),
      ),
    );

    GetIt.instance.registerSingleton<ICrowdActionRepository>(crowdActionRepo);
  }
}
