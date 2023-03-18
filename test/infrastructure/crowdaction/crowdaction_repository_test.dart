import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/core/i_settings_repository.mocks.dart';
import '../../test_utilities.dart';
import 'crowdaction_repository_fixtures.dart';

void main() {
  late final IAuthRepository authRepository;
  late final ISettingsRepository settingsRepository;
  late final MockHttpClient client;
  late final CrowdActionRepository crowdActionRepository;

  setUpAll(() {
    registerFallbackValue(Uri());

    authRepository = MockAuthRepository();
    settingsRepository = SettingsRepositoryMock();
    client = MockHttpClient();

    crowdActionRepository = CrowdActionRepository(
      client,
      authRepository,
      settingsRepository,
    );

    when(() => settingsRepository.baseApiEndpointUrl)
        .thenAnswer((invocation) => Future.value('https://example.com'));
  });

  group('CrowdActionRepository tests', () {
    test('getCrowdAction success', () async {
      when(() => client.get(any())).thenAnswer(
          (invocation) => Future.value(Response(crowdActionRaw, 200)));

      final crowdActionEither =
          await crowdActionRepository.getCrowdAction('12345678');

      expect(crowdActionEither.isRight(), true);

      final crowdAction = crowdActionEither.fold((l) => null, (r) => r);
      expect(crowdAction, isNotNull);
    });

    test('getCrowdAction failure', () async {
      when(() => client.get(any()))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      final crowdActionEither =
          await crowdActionRepository.getCrowdAction('12345678');

      expect(crowdActionEither.isLeft(), true);
    });

    test('getCrowdAction failure by exception', () async {
      when(() => client.get(any()))
          .thenAnswer((invocation) => throw Exception());

      final crowdActionEither =
          await crowdActionRepository.getCrowdAction('12345678');

      expect(crowdActionEither.isLeft(), true);
    });

    test('getCrowdActions success', () async {
      when(() => client.get(any())).thenAnswer(
          (invocation) => Future.value(Response(crowdActionsRaw, 200)));

      final paginatedCrowdActionEither =
          await crowdActionRepository.getCrowdActions(pageNumber: 1);

      expect(paginatedCrowdActionEither.isRight(), true);

      final paginatedCrowdActions =
          paginatedCrowdActionEither.fold((l) => null, (r) => r);
      expect(paginatedCrowdActions, isNotNull);

      expect(paginatedCrowdActions!.crowdActions.length, 2);
    });

    test('getCrowdActions failure', () async {
      when(() => client.get(any()))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      final paginatedCrowdActionEither =
          await crowdActionRepository.getCrowdActions(pageNumber: 1);

      expect(paginatedCrowdActionEither.isLeft(), true);

      final paginatedCrowdActions =
          paginatedCrowdActionEither.fold((l) => null, (r) => r);
      expect(paginatedCrowdActions, isNull);
    });

    test('getCrowdActions failure by exception', () async {
      when(() => client.get(any()))
          .thenAnswer((invocation) => throw Exception());

      final paginatedCrowdActionEither =
          await crowdActionRepository.getCrowdActions(pageNumber: 1);

      expect(paginatedCrowdActionEither.isLeft(), true);

      final paginatedCrowdActions =
          paginatedCrowdActionEither.fold((l) => null, (r) => r);
      expect(paginatedCrowdActions, isNull);
    });

    test('getSpotlightCrowdActions success', () async {
      when(() => client.get(any())).thenAnswer(
          (invocation) => Future.value(Response(crowdActionsRaw, 200)));

      final paginatedCrowdActionEither =
          await crowdActionRepository.getSpotlightCrowdActions();

      expect(paginatedCrowdActionEither.isRight(), true);

      final paginatedCrowdActions =
          paginatedCrowdActionEither.fold((l) => null, (r) => r);
      expect(paginatedCrowdActions, isNotNull);
    });

    test('getSpotlightCrowdActions failure', () async {
      when(() => client.get(any()))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      final paginatedCrowdActionEither =
          await crowdActionRepository.getSpotlightCrowdActions();

      expect(paginatedCrowdActionEither.isLeft(), true);

      final paginatedCrowdActions =
          paginatedCrowdActionEither.fold((l) => null, (r) => r);
      expect(paginatedCrowdActions, isNull);
    });

    test('getSpotlightCrowdActions failure by exception', () async {
      when(() => client.get(any()))
          .thenAnswer((invocation) => throw Exception());

      final paginatedCrowdActionEither =
          await crowdActionRepository.getSpotlightCrowdActions();

      expect(paginatedCrowdActionEither.isLeft(), true);

      final paginatedCrowdActions =
          paginatedCrowdActionEither.fold((l) => null, (r) => r);
      expect(paginatedCrowdActions, isNull);
    });

    test('getCrowdActionsForUser success', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(crowdActionsRaw, 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final crowdActionEither =
          await crowdActionRepository.getCrowdActionsForUser();

      expect(crowdActionEither.isRight(), true);

      final crowdAction = crowdActionEither.fold((l) => null, (r) => r);
      expect(crowdAction, isNotNull);
    });

    test('getCrowdActionsForUser failure', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenAnswer((invocation) => Future.value(Response('', 400)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(User.anonymous)));

      final crowdActionEither =
          await crowdActionRepository.getCrowdActionsForUser();

      expect(crowdActionEither.isLeft(), true);

      final crowdAction = crowdActionEither.fold((l) => null, (r) => r);
      expect(crowdAction, isNull);
    });

    test('getCrowdActionsForUser failure by null user', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(crowdActionsRaw, 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => Future.value(optionOf(null)));

      final crowdActionEither =
          await crowdActionRepository.getCrowdActionsForUser();

      expect(crowdActionEither.isLeft(), true);

      final crowdAction = crowdActionEither.fold((l) => null, (r) => r);
      expect(crowdAction, isNull);
    });

    test('getCrowdActionsForUser failure by excpetion', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
          (invocation) => Future.value(Response(crowdActionsRaw, 200)));

      when(() => authRepository.getSignedInUser())
          .thenAnswer((invocation) => throw Exception());

      final crowdActionEither =
          await crowdActionRepository.getCrowdActionsForUser();

      expect(crowdActionEither.isLeft(), true);

      final crowdAction = crowdActionEither.fold((l) => null, (r) => r);
      expect(crowdAction, isNull);
    });
  });
}
