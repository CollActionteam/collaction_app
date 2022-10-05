import 'dart:convert';

import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/profile/user_profile.dart';
import 'package:collaction_app/domain/user/i_profile_repository.dart';
import 'package:collaction_app/domain/user/profile_failure.dart';
import 'package:collaction_app/infrastructure/profile/profile_dto.dart';
import 'package:collaction_app/infrastructure/profile/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../domain/profile/profile_fixture.dart';
import '../../domain/user/user_fixture.dart';
import '../../test_utilities.dart';

void main() {
  late IProfileRepository profileRepository;
  late IAuthRepository authRepository;
  late http.Client client;
  late ISettingsRepository settingsRepository;

  const baseUrl = 'https://example.com';
  final profileGetUrl = Uri.parse('$baseUrl/v1/profiles/me');
  final profilePostUrl = Uri.parse('$baseUrl/v1/profiles');
  const profileJson = cProfileDtoJson;

  /// Auth
  const user = cUser;
  final profile = ProfileDto.fromJson(profileJson).toDomain();
  final userProfile = UserProfile(user: cUser, profile: profile);
  const httpHeader = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $cAuthToken',
  };

  setUp(() {
    authRepository = MockAuthRepository();
    client = MockHttpClient();
    settingsRepository = MockSettingsRepository();
    profileRepository = ProfileRepository(
      authRepository,
      client,
      settingsRepository,
    );

    when(() => settingsRepository.baseApiEndpointUrl)
        .thenAnswer((_) async => baseUrl);
  });

  test(
      'should return [ProfileFailure.noUser()] '
      'when [getUserProfile] is called and user is not authenticated',
      () async {
    /// arrange
    when(() => authRepository.getSignedInUser())
        .thenAnswer((_) async => none());

    /// act
    final resultOrFailure = await profileRepository.getUserProfile();

    /// assert
    expect(resultOrFailure.isLeft(), equals(true));
    expect((resultOrFailure as Left).value, isA<NoUser>());

    verifyNever(() => client.get(profileGetUrl));
  });

  test(
      'should return user profile '
      'when [getUserProfile] is called, the user is authenticated '
      'and the http request to get profile is successful', () async {
    /// arrange
    when(() => authRepository.getSignedInUser())
        .thenAnswer((_) async => some(user));

    when(() => client.get(profileGetUrl, headers: any(named: 'headers')))
        .thenAnswer((_) async {
      return http.Response(jsonEncode(profileJson), 200);
    });

    /// act
    final resultOrFailure = await profileRepository.getUserProfile();

    /// assert
    expect(resultOrFailure.isRight(), equals(true));
    expect((resultOrFailure as Right).value, equals(userProfile));

    verify(() => client.get(profileGetUrl, headers: httpHeader)).called(1);
  });

  test(
      'should create user profile '
      'when [getUserProfile] is called, the user is authenticated '
      'and the http request to get profile is unsuccessful', () async {
    /// arrange
    when(() => authRepository.getSignedInUser())
        .thenAnswer((_) async => some(user));

    final List<Future<http.Response> Function(Invocation)> responses = [
      /// First request fails to obtain profile
      (_) async => http.Response(jsonEncode({}), 500),

      /// After profile creation request, second call should pass
      (_) async => http.Response(jsonEncode(profileJson), 200),
    ];

    when(() => client.get(profileGetUrl, headers: any(named: 'headers')))
        .thenAnswer((invocation) => responses.removeAt(0)(invocation));

    when(
      () => client.post(
        profilePostUrl,
        headers: any(named: 'headers'),
        body: any(named: 'body'),
      ),
    ).thenAnswer((_) async {
      return http.Response(jsonEncode({}), 201);
    });

    /// act
    final resultOrFailure = await profileRepository.getUserProfile();

    /// assert
    expect(resultOrFailure.isRight(), equals(true));
    expect((resultOrFailure as Right).value, equals(userProfile));

    verify(() => client.get(profileGetUrl, headers: httpHeader)).called(2);
    verify(
      () => client.post(
        profilePostUrl,
        headers: httpHeader,
        body: jsonEncode({
          "firstName": userProfile.profile.firstName,
          "lastName": userProfile.profile.lastName,
          "country": "NL",
          "bio": "My bio is currently empty",
        }),
      ),
    ).called(1);
  });

  /// TODO(obella): Add more tests
}
