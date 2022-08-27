import 'dart:async';
import 'dart:convert';

import 'package:collaction_app/domain/auth/errors.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/crowdaction/participant.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/auth/i_auth_repository.dart';
import '../../domain/profile/user_profile.dart';
import '../../domain/user/i_profile_repository.dart';
import '../../domain/user/profile_failure.dart';
import '../../domain/user/user.dart';
import '../../infrastructure/profile/profile_dto.dart';

@LazySingleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final IAuthRepository _authRepository;
  final http.Client _client;
  final ISettingsRepository _settingsRepository;

  const ProfileRepository(
    this._authRepository,
    this._client,
    this._settingsRepository,
  );

  @override
  Future<Either<ProfileFailure, UserProfile>> getUserProfile() async {
    try {
      final userOption = await _authRepository.getSignedInUser();

      return await userOption.fold(
        () => left(const ProfileFailure.noUser()),
        (user) async {
          var userProfile = await _getUserProfile(user);

          if (userProfile != null) {
            return right(userProfile);
          }

          /// If user has no profile, create one
          /// TODO(obella): Cleanup later
          final resultOrFailure = await createProfile();

          if (resultOrFailure.isRight()) {
            userProfile = await _getUserProfile(user);
            return right(userProfile!);
          }

          return left(const ProfileFailure.noUser());
        },
      );
    } catch (_) {
      return left(const ProfileFailure.unexpected());
    }
  }

  @override
  Future<Either<ProfileFailure, Unit>> createProfile() async {
    try {
      final userOption = await _authRepository.getSignedInUser();

      return await userOption.fold(
        () => left(const ProfileFailure.noUser()),
        (user) async {
          final tokenId = await user.getIdToken();

          final response = await _client.post(
            Uri.parse(
              '${await _settingsRepository.baseApiEndpointUrl}/api/v1/profiles',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $tokenId',
            },

            /// TODO: Refactor to include actual country and city
            body: jsonEncode({
              "firstName": user.displayName,
              "lastName": "",
              "country": "NL",
              "bio": "My bio is currently empty",
            }),
          );

          if (response.statusCode == 201) {
            return right(unit);
          }

          return left(const ProfileFailure.unexpected());
        },
      );
    } catch (_) {
      return left(const ProfileFailure.unexpected());
    }
  }

  @override
  Future<Either<ProfileFailure, Unit>> saveProfile({
    String? bio,
  }) async {
    try {
      final userOption = await _authRepository.getSignedInUser();

      return await userOption.fold(
        () => left(const ProfileFailure.noUser()),
        (user) async {
          final token = await user.getIdToken();

          final response = await _client.put(
            Uri.parse(
              '${await _settingsRepository.baseApiEndpointUrl}/api/v1/profiles',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              "bio": bio,
            }),
          );

          if (response.statusCode == 200) {
            return right(unit);
          }

          return left(const ProfileFailure.unexpected());
        },
      );
    } catch (_) {
      return left(const ProfileFailure.unexpected());
    }
  }

  /// Get user profile from api
  Future<UserProfile?> _getUserProfile(User user) async {
    final tokenId = await user.getIdToken();

    final response = await _client.get(
      Uri.parse(
        '${await _settingsRepository.baseApiEndpointUrl}/api/v1/profiles/me',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenId'
      },
    );

    /// Return profile if request is successful
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final profile =
          ProfileDto.fromJson(json as Map<String, dynamic>).toDomain();

      return UserProfile(user: user, profile: profile);
    }

    return null;
  }

  @override
  Future<Either<ProfileFailure, List<Participant>>> fetchParticipantsProfile({
    required String crowdactionId,
    required int page,
  }) async {
    final tokenId = (await _authRepository.getSignedInUser())
        .fold(() => throw NotAuthenticatedError(), (a) => a.id);

    final parameters = 'page=$page&pageSize=15&crowdActionId=$crowdactionId';
    final url =
        '${await _settingsRepository.baseApiEndpointUrl}/api/v1/participations?$parameters';

    final response = await _client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenId',
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final participantsJson = json['items'] as List<dynamic>?;
      final List<Participant> participants =
          participantsJson!.map<Participant>((participant) {
        return Participant.fromJson(participant as Map<String, dynamic>);
      }).toList();
      return right(participants);
    } else {
      return left(const ProfileFailure.errorFetchingParticipants());
    }
  }
}
