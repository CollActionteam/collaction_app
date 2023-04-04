import 'dart:convert';

import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/participation/participation.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/infrastructure/participation/participation_dto.dart';
import 'package:collaction_app/infrastructure/participation/participation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/core/i_settings_repository.mocks.dart';
import '../../domain/user/user_fixture.dart';
import '../../test_utilities.dart';
import 'participation_repository_fixtures.dart';

void main() {
  late final IAuthRepository authRepository;
  late final ISettingsRepository settingsRepository;
  late MockHttpClient client;
  late ParticipationRepository participationRepository;
  const baseUrl = 'https://example.com';
  late final Participation userParticipation;

  setUpAll(() {
    registerFallbackValue(Uri());

    authRepository = MockAuthRepository();
    settingsRepository = SettingsRepositoryMock();

    when(() => settingsRepository.baseApiEndpointUrl)
        .thenAnswer((invocation) => Future.value(baseUrl));

    userParticipation = ParticipationDto.fromJson(
      jsonDecode(participation1) as Map<String, dynamic>,
    ).toDomain();

    // Setup Auth Repo
    final user = cUser.copyWith(id: userParticipation.userId);

    when(() => authRepository.getSignedInUser())
        .thenAnswer((_) async => some(user));

    when(() => authRepository.currentUser).thenAnswer((_) => user);
  });

  setUp(() {
    client = MockHttpClient();

    participationRepository = ParticipationRepository(
      client,
      authRepository,
      settingsRepository,
    );
  });

  group('[getParticipation]', () {
    test('success', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(participation1, 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .getParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isRight(), true);
    });

    test('failure by 500', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 500)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .getParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });

    test('failure', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .getParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });

    test('failure by exception', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(participation1, 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => throw Exception());

      final participationOrFailure = await participationRepository
          .getParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });
  });

  group('[toggleParticipation]', () {
    test('success', () async {
      when(() => client.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .toggleParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isRight(), true);
    });

    test('failure', () async {
      when(() => client.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .toggleParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });

    test('failure by exception', () async {
      when(() => client.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => throw Exception());

      final participationOrFailure = await participationRepository
          .toggleParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });
  });

  group('[getParticipations]', () {
    final Uri page1Uri = Uri.parse(
      '$baseUrl/v1/participations?crowdActionId=${userParticipation.crowdActionId}&page=1',
    );
    
    final Uri page2Uri = Uri.parse(
      '$baseUrl/v1/participations?crowdActionId=${userParticipation.crowdActionId}&page=2',
    );
    
    final Uri participationUri = Uri.parse(
      '$baseUrl/v1/participations/${userParticipation.crowdActionId}',
    );

    test(
        'should prepend current user to top of participation list '
        'when page 1 is loaded and user is not in participation list',
        () async {
      when(() => client.get(participationUri, headers: any(named: 'headers')))
          .thenAnswer(
              (invocation) => Future.value(Response(participation1, 200)));

      when(
        () => client.get(
          page1Uri,
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Response(ParticipationFixtures.PAGE_1_WITHOUT_USER.json, 200),
        ),
      );

      final paginatedParticipationsOrFailure = await participationRepository
          .getParticipations(crowdActionId: userParticipation.crowdActionId);

      expect(paginatedParticipationsOrFailure.isRight(), true);

      final paginatedParticipations = paginatedParticipationsOrFailure.fold(
        (l) => null,
        (r) => r,
      );
      expect(paginatedParticipations, isNotNull);

      expect(paginatedParticipations!.participations.length, 3);
      expect(paginatedParticipations.participations.first, userParticipation);

      verify(() => client.get(participationUri, headers: any(named: 'headers')))
          .called(1);
    });

    test(
        'should swap current user with user at top of participation list '
        'when page 1 is loaded and user is in participation list', () async {
      when(
        () => client.get(
          page1Uri,
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Response(ParticipationFixtures.PAGE_1_WITH_USER.json, 200),
        ),
      );

      final paginatedParticipationsOrFailure = await participationRepository
          .getParticipations(crowdActionId: userParticipation.crowdActionId);

      expect(paginatedParticipationsOrFailure.isRight(), true);

      final paginatedParticipations = paginatedParticipationsOrFailure.fold(
        (l) => null,
        (r) => r,
      );
      expect(paginatedParticipations, isNotNull);

      expect(paginatedParticipations!.participations.length, 2);
      expect(paginatedParticipations.participations.first, userParticipation);

      verifyNever(
        () => client.get(
          participationUri,
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
        'should keep current user at top of participation list '
        'when page 1 is loaded and user is first in participation list',
        () async {
      when(
        () => client.get(
          page1Uri,
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Response(ParticipationFixtures.PAGE_1_WITH_USER_AS_FIRST.json, 200),
        ),
      );

      final paginatedParticipationsOrFailure = await participationRepository
          .getParticipations(crowdActionId: userParticipation.crowdActionId);

      expect(paginatedParticipationsOrFailure.isRight(), true);

      final paginatedParticipations = paginatedParticipationsOrFailure.fold(
        (l) => null,
        (r) => r,
      );
      expect(paginatedParticipations, isNotNull);

      expect(paginatedParticipations!.participations.length, 2);
      expect(paginatedParticipations.participations.first, userParticipation);

      verifyNever(
        () => client.get(
          participationUri,
          headers: any(named: 'headers'),
        ),
      );
    });

    test(
        'should remove current user from participation list '
        'when page N>1 is loaded and user is in participation list', () async {
      when(
        () => client.get(
          page2Uri,
          headers: any(named: 'headers'),
        ),
      ).thenAnswer(
        (invocation) => Future.value(
          Response(ParticipationFixtures.PAGE_2_WITH_USER.json, 200),
        ),
      );

      final paginatedParticipationsOrFailure =
          await participationRepository.getParticipations(
        crowdActionId: userParticipation.crowdActionId,
        pageNumber: 2,
      );

      expect(paginatedParticipationsOrFailure.isRight(), true);

      final paginatedParticipations = paginatedParticipationsOrFailure.fold(
        (l) => null,
        (r) => r,
      );
      expect(paginatedParticipations, isNotNull);

      expect(paginatedParticipations!.participations.length, 1);
      expect(
        paginatedParticipations.participations.contains(userParticipation),
        false,
      );

      verifyNever(
        () => client.get(
          participationUri,
          headers: any(named: 'headers'),
        ),
      );
    });

    test('failure', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      final paginatedParticipationsOrFailure = await participationRepository
          .getParticipations(crowdActionId: '123456');

      expect(paginatedParticipationsOrFailure.isLeft(), true);

      final paginatedParticipations =
          paginatedParticipationsOrFailure.fold((l) => null, (r) => r);
      expect(paginatedParticipations, isNull);
    });

    test('failure by exception', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => throw Exception());

      final paginatedParticipationsOrFailure = await participationRepository
          .getParticipations(crowdActionId: '123456');

      expect(paginatedParticipationsOrFailure.isLeft(), true);

      final paginatedParticipations =
          paginatedParticipationsOrFailure.fold((l) => null, (r) => r);
      expect(paginatedParticipations, isNull);
    });
  });

  group('[getTopParticipants]', () {
    test('success', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(
              Response(ParticipationFixtures.PAGE_1_WITH_USER.json, 200)));

      final participationsOrFailure = await participationRepository
          .getTopParticipants(crowdActionId: '123456');

      expect(participationsOrFailure.isRight(), true);

      final participations =
          participationsOrFailure.fold((l) => null, (r) => r);
      expect(participations, isNotNull);

      expect(participations!.length, 2);
    });

    test('failure', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      final participationsOrFailure = await participationRepository
          .getTopParticipants(crowdActionId: '123456');

      expect(participationsOrFailure.isLeft(), true);

      final participations =
          participationsOrFailure.fold((l) => null, (r) => r);
      expect(participations, isNull);
    });

    test('failure by exception', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => throw Exception());

      final participationsOrFailure = await participationRepository
          .getTopParticipants(crowdActionId: '123456');

      expect(participationsOrFailure.isLeft(), true);

      final participations =
          participationsOrFailure.fold((l) => null, (r) => r);
      expect(participations, isNull);
    });
  });
}
