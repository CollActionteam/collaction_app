import 'dart:io';

import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/contact_form/contact_failures.dart';
import 'package:collaction_app/domain/contact_form/contact_form_dto.dart';
import 'package:collaction_app/domain/contact_form/i_contact_form_api.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction.dart';
import 'package:collaction_app/domain/crowdaction/crowdaction_status.dart';
import 'package:collaction_app/domain/crowdaction/i_crowdaction_repository.dart';
import 'package:collaction_app/domain/user/i_avatar_repository.dart';
import 'package:collaction_app/domain/user/i_profile_repository.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'domain/crowdaction/crowdaction_test_fixtures.dart';
import 'utils/crowdactions.dart';

class MockCrowdActionRepository extends Mock implements ICrowdActionRepository {
}

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockSettingsRepository extends Mock implements ISettingsRepository {}

class MockContactFormApi extends Mock implements IContactRepository {}

class MockAvatarRepository extends Mock implements IAvatarRepository {}

class MockAvatarFile extends Mock implements File {}

class MockProfileRepository extends Mock implements IProfileRepository {}

class MockHttpClient extends Mock implements http.Client {}

// ignore: avoid_positional_boolean_parameters
Future<String?> getAnonymousIdToken([bool forceRefresh = false]) =>
    Future.value();

// ignore: avoid_classes_with_only_static_members
class TestUtilities {
  static void mockUser(Stream<User> userStream) {
    final mockUserRepository = MockUserRepository();
    when(() => mockUserRepository.observeUser()).thenAnswer((_) => userStream);
    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<IUserRepository>(mockUserRepository);
  }

  static void mockContactFormApi({
    required bool doesSubmissionSucceed,
  }) {
    registerFallbackValue(ContactFormDto(email: '', message: ''));

    final mockContactFormApi = MockContactFormApi();

    when(() => mockContactFormApi.sendContactFormContents(any())).thenAnswer(
      (_) async => doesSubmissionSucceed
          ? right(unit)
          : left(const ContactFailure.serverError()),
    );

    GetIt.I.allowReassignment = true;
    GetIt.I.registerSingleton<IContactRepository>(mockContactFormApi);
  }

  static void mockCrowdActionApi() {
    registerFallbackValue(crowdActions.first.toDomain());

    final crowdActionRepo = MockCrowdActionRepository();

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
          crowdActions.first.commitmentOptions.map((e) => e.id).toList(),
        ),
      ),
    );

    GetIt.instance.registerSingleton<ICrowdActionRepository>(crowdActionRepo);
  }
}

final tCrowdaction = CrowdAction(
  id: 'tID',
  type: '',
  title: 'tTitle',
  description: 'tDescription',
  category: 'tCategory',
  location: tLocation,
  commitmentOptions: [tCommitmentOption],
  endAt: DateTime(2022, 1, 31),
  images: const Images(card: 'tCard', banner: 'tBanner'),
  participantCount: 10,
  status: Status.ended,
  joinStatus: JoinStatus.closed,
  password: 'testPwd',
);

final tCommitmentOption = CommitmentOption(
  id: 'no-beef',
  type: 'food',
  label: 'tLabel',
  description: 'tDescription',
  points: 0,
  blocks: [],
);

final List<String> tCommitment = ['tCommitment'];
