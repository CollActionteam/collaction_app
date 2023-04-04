import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/auth/errors.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/core/i_settings_repository.dart';
import '../../domain/participation/i_participation_repository.dart';
import '../../domain/participation/paginated_participations.dart';
import '../../domain/participation/participation.dart';
import '../../domain/participation/participation_failures.dart';
import '../core/page_info_dto.dart';
import 'participation_dto.dart';

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
    List<String>? commitments,
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
          'commitments': commitments,
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
            (item) => ParticipationDto.fromJson(item as Map<String, dynamic>)
                .toDomain(),
          )
          .toList();

      final pageInfo = PageInfoDto.fromJson(pageInfoJson);

      // To display user as first participant,
      // Get user participation for first page
      if (pageNumber == 1) {
        int index = participations.indexWhere(
          (p) => p.userId == authRepository.currentUser.id,
        );

        // If user already among participants
        // skip fetching user participation
        if (index > -1) {
          // If user participation is in list,
          // and not first, swap with first user
          if (index > 0) {
            final temp = participations[index];
            participations[index] = participations.first;
            participations[0] = temp;
          }

          return right(
            PaginatedParticipations(
              participations: participations,
              pageInfo: pageInfo.toDomain(),
            ),
          );
        }

        // Fetch user participation
        final participationResult =
            await getParticipation(crowdActionId: crowdActionId);

        if (participationResult.isRight()) {
          // prepend user as first participant
          final participation =
              participationResult.getOrElse(() => throw Exception());

          participations.insert(0, participation);
        }
      } else {
        // Check if user exists among current participants and remove
        int index = participations.indexWhere(
          (p) => p.userId == authRepository.currentUser.id,
        );

        if (index > -1) {
          participations.removeAt(index);
        }
      }

      return right(
        PaginatedParticipations(
          participations: participations,
          pageInfo: pageInfo.toDomain(),
        ),
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
