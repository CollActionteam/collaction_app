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

  const _baseUrl = 'https://example.com';
  final _profileGetUrl = Uri.parse('$_baseUrl/v1/profiles/me');
  final _profilePostUrl = Uri.parse('$_baseUrl/v1/profiles');
  const _profileJson = cProfileDtoJson;

  /// Auth
  const _user = cUser;
  final _profile = ProfileDto.fromJson(_profileJson).toDomain();
  final _userProfile = UserProfile(user: cUser, profile: _profile);
  const _httpHeader = {
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
        .thenAnswer((_) async => _baseUrl);
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

    verifyNever(() => client.get(_profileGetUrl));
  });

  test(
      'should return user profile '
      'when [getUserProfile] is called, the user is authenticated '
      'and the http request to get profile is successful', () async {
    /// arrange
    when(() => authRepository.getSignedInUser())
        .thenAnswer((_) async => some(_user));

    when(() => client.get(_profileGetUrl, headers: any(named: 'headers')))
        .thenAnswer((_) async {
      return http.Response(jsonEncode(_profileJson), 200);
    });

    /// act
    final resultOrFailure = await profileRepository.getUserProfile();

    /// assert
    expect(resultOrFailure.isRight(), equals(true));
    expect((resultOrFailure as Right).value, equals(_userProfile));

    verify(() => client.get(_profileGetUrl, headers: _httpHeader)).called(1);
  });

  test(
      'should create user profile '
      'when [getUserProfile] is called, the user is authenticated '
      'and the http request to get profile is unsuccessful', () async {
    /// arrange
    when(() => authRepository.getSignedInUser())
        .thenAnswer((_) async => some(_user));

    final List<Future<http.Response> Function(Invocation)> responses = [
      /// First request fails to obtain profile
      (_) async => http.Response(jsonEncode({}), 500),

      /// After profile creation request, second call should pass
      (_) async => http.Response(jsonEncode(_profileJson), 200),
    ];

    when(() => client.get(_profileGetUrl, headers: any(named: 'headers')))
        .thenAnswer((invocation) => responses.removeAt(0)(invocation));

    when(
      () => client.post(
        _profilePostUrl,
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
    expect((resultOrFailure as Right).value, equals(_userProfile));

    verify(() => client.get(_profileGetUrl, headers: _httpHeader)).called(2);
    verify(
      () => client.post(
        _profilePostUrl,
        headers: _httpHeader,
        body: jsonEncode({
          "firstName": _user.firstname,
          "lastName": "",
          "country": "NL",
          "bio": "My bio is currently empty",
        }),
      ),
    ).called(1);
  });

  /// TODO(obella): Add more tests
}
