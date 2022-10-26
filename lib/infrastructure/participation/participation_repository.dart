import 'dart:convert';

import 'package:collaction_app/domain/auth/errors.dart';
import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/participation/i_participation_repository.dart';
import 'package:collaction_app/domain/participation/paginated_participations.dart';
import 'package:collaction_app/domain/participation/participation.dart';
import 'package:collaction_app/domain/participation/participation_failures.dart';
import 'package:collaction_app/infrastructure/participation/paginated_participations_dto.dart';
import 'package:collaction_app/infrastructure/participation/participation_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../core/page_info_dto.dart';

@LazySingleton(as: IParticipationRepository)
class ParticipationRepository implements IParticipationRepository {
  final http.Client client;
  final IAuthRepository authRepository;
  final ISettingsRepository settingsRepository;

  const ParticipationRepository(
    this.client,
    this.authRepository,
    this.settingsRepository,
  );

  @override
  Future<Either<ParticipationFailure, Participation>> getParticipation({
    required String crowdActionId,
  }) async {
    try {
      final user = (await authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());
      final token = await user.getIdToken();

      final uri = Uri.parse(
        '${await settingsRepository.baseApiEndpointUrl}/v1/participations/$crowdActionId',
      );

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return right(
          ParticipationDto.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>,
          ).toDomain(),
        );
      } else if (response.statusCode == 500) {
        return left(const ParticipationFailure.notParticipating());
      } else {
        return left(const ParticipationFailure.serverError());
      }
    } catch (_) {
      return left(const ParticipationFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<ParticipationFailure, Unit>> toggleParticipation({
    required String crowdActionId,
    List<String>? commitmentOptions,
  }) async {
    try {
      final user = (await authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());
      final token = await user.getIdToken();

      final uri = Uri.parse(
        '${await settingsRepository.baseApiEndpointUrl}/v1/participations',
      );

      final response = await client.post(
        uri,
        body: json.encode({
          'crowdActionId': crowdActionId,
          'commitmentOptions': commitmentOptions,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(const ParticipationFailure.serverError());
      }
    } catch (_) {
      return left(const ParticipationFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<ParticipationFailure, PaginatedParticipations>>
      getParticipations({
    required String crowdActionId,
    int pageNumber = 1,
  }) async {
    try {
      final uri = Uri.parse(
        '${await settingsRepository.baseApiEndpointUrl}/v1/participations?crowdActionId=$crowdActionId&page=$pageNumber',
      );

      final response = await client.get(
        uri,
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final itemsJson = json['items'] as List<dynamic>;
      final pageInfoJson = json['pageInfo'] as Map<String, dynamic>;

      final participations = itemsJson
          .map(
            (item) => ParticipationDto.fromJson(item as Map<String, dynamic>),
          )
          .toList();

      final pageInfo = PageInfoDto.fromJson(pageInfoJson);

      return right(
        PaginatedParticipationsDto(
          participations: participations,
          pageInfo: pageInfo,
        ).toDomain(),
      );
    } catch (ex) {
      return left(const ParticipationFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<ParticipationFailure, List<Participation>>> getTopParticipants({
    required String crowdActionId,
  }) async {
    try {
      final response = await client.get(
        Uri.parse(
          '${await settingsRepository.baseApiEndpointUrl}/v1/participations?crowdActionId=$crowdActionId&pageSize=3',
        ),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)['items'] as List<dynamic>;
        final participations = json
            .map(
              (item) => ParticipationDto.fromJson(item as Map<String, dynamic>)
                  .toDomain(),
            )
            .toList();

        return right(participations);
      }

      return left(const ParticipationFailure.serverError());
    } catch (ex) {
      return left(const ParticipationFailure.networkRequestFailed());
    }
  }
}
