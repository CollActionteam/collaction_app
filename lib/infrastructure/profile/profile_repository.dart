import 'dart:async';
import 'dart:convert';

import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/auth/errors.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/profile/user_profile.dart';
import '../../domain/user/i_profile_repository.dart';
import '../../domain/user/profile_failure.dart';
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
          final user = (await _authRepository.getSignedInUser())
              .getOrElse(() => throw NotAuthenticatedError());
          final tokenId = await user.getIdToken();

          final response = await _client.get(
            Uri.parse(
              '${await _settingsRepository.baseApiEndpointUrl}/profiles/${user.id}',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $tokenId'
            },
          );

          final json = jsonDecode(response.body);
          if (json['message'] != null && response.statusCode == 404) {
            /// TODO: Refactor, don't create others profiles!
            final result = await createProfile();
            final created = result.fold((failure) => false, (unit) => true);

            if (!created) {
              return left(const ProfileFailure.unexpected());
            }

            final failureOrProfile = await getUserProfile();
            return failureOrProfile.fold(
              (failure) => left(const ProfileFailure.unexpected()),
              (profile) => right(profile),
            );
          }

          final profile =
              ProfileDto.fromJson(json['data'] as Map<String, dynamic>)
                  .toDomain();

          return right(UserProfile(user: user, profile: profile));
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
          final user = (await _authRepository.getSignedInUser())
              .getOrElse(() => throw NotAuthenticatedError());
          final tokenId = await user.getIdToken();

          final response = await _client.post(
            Uri.parse(
              '${await _settingsRepository.baseApiEndpointUrl}/profiles/${user.id}',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $tokenId',
            },

            /// TODO: Refactor to include actual country and city
            body: jsonEncode({
              "displayname": user.displayName,
              "country": "The Netherlands",
              "city": "Amsterdam",
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
          final user = (await _authRepository.getSignedInUser())
              .getOrElse(() => throw NotAuthenticatedError());
          final tokenId = await user.getIdToken();

          final response = await _client.put(
            Uri.parse(
              '${await _settingsRepository.baseApiEndpointUrl}/profiles/${user.id}',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $tokenId',
            },

            /// TODO: Refactor to include actual country and city
            body: jsonEncode({
              "displayname": user.displayName,
              "country": "The Netherlands",
              "city": "Amsterdam",
              "bio": bio,
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
}
