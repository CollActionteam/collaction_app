import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/infrastructure/participation/participation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/core/i_settings_repository.mocks.dart';
import '../../test_utilities.dart';
import 'participation_repository_fixtures.dart';

void main() {
  late final IAuthRepository authRepository;
  late final ISettingsRepository settingsRepository;
  late final MockHttpClient client;
  late final ParticipationRepository participationRepository;

  setUpAll(() {
    registerFallbackValue(Uri());

    authRepository = MockAuthRepository();
    settingsRepository = SettingsRepositoryMock();
    client = MockHttpClient();

    participationRepository = ParticipationRepository(
      client,
      authRepository,
      settingsRepository,
    );

    when(() => settingsRepository.baseApiEndpointUrl)
        .thenAnswer((invocation) => Future.value('https://example.com'));
  });

  group('ParticipationRepository tests', () {
    test('getParticipation success', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(participationRaw, 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .getParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isRight(), true);
    });

    test('getParticipation failure by 500', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 500)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .getParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });

    test('getParticipation failure', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .getParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });

    test('getParticipation failure by exception', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(participationRaw, 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => throw Exception());

      final participationOrFailure = await participationRepository
          .getParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });

    test('toggleParticipation success', () async {
      when(() => client.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .toggleParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isRight(), true);
    });

    test('toggleParticipation failure', () async {
      when(() => client.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final participationOrFailure = await participationRepository
          .toggleParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });

    test('toggleParticipation failure by exception', () async {
      when(() => client.post(any(),
              body: any(named: 'body'), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => throw Exception());

      final participationOrFailure = await participationRepository
          .toggleParticipation(crowdActionId: '123456');

      expect(participationOrFailure.isLeft(), true);
    });

    test('getParticipations success', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(participationsRaw, 200)));

      final paginatedParticipationsOrFailure = await participationRepository
          .getParticipations(crowdActionId: '123456');

      expect(paginatedParticipationsOrFailure.isRight(), true);

      final paginatedParticipations =
          paginatedParticipationsOrFailure.fold((l) => null, (r) => r);
      expect(paginatedParticipations, isNotNull);

      expect(paginatedParticipations!.participations.length, 2);
    });

    test('getParticipations failure', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      final paginatedParticipationsOrFailure = await participationRepository
          .getParticipations(crowdActionId: '123456');

      expect(paginatedParticipationsOrFailure.isLeft(), true);

      final paginatedParticipations =
          paginatedParticipationsOrFailure.fold((l) => null, (r) => r);
      expect(paginatedParticipations, isNull);
    });

    test('getParticipations failure by exception', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => throw Exception());

      final paginatedParticipationsOrFailure = await participationRepository
          .getParticipations(crowdActionId: '123456');

      expect(paginatedParticipationsOrFailure.isLeft(), true);

      final paginatedParticipations =
          paginatedParticipationsOrFailure.fold((l) => null, (r) => r);
      expect(paginatedParticipations, isNull);
    });

    test('getTopParticipants success', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(participationsRaw, 200)));

      final participationsOrFailure = await participationRepository
          .getTopParticipants(crowdActionId: '123456');

      expect(participationsOrFailure.isRight(), true);

      final participations =
          participationsOrFailure.fold((l) => null, (r) => r);
      expect(participations, isNotNull);

      expect(participations!.length, 2);
    });

    test('getTopParticipants failure', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      final participationsOrFailure = await participationRepository
          .getTopParticipants(crowdActionId: '123456');

      expect(participationsOrFailure.isLeft(), true);

      final participations =
          participationsOrFailure.fold((l) => null, (r) => r);
      expect(participations, isNull);
    });

    test('getTopParticipants failure by exception', () async {
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
