import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/auth/errors.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/core/i_settings_repository.dart';
import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/crowdaction_failures.dart';

import '../../domain/crowdaction/i_crowdaction_repository.dart';
import '../../domain/crowdaction/paginated_crowdactions.dart';
import '../core/page_info_dto.dart';
import 'crowdaction_dto.dart';

import 'paginated_crowdactions_dto.dart';

@LazySingleton(as: ICrowdActionRepository)
class CrowdActionRepository implements ICrowdActionRepository {
  final http.Client _client;
  final IAuthRepository _authRepository;
  final ISettingsRepository _settingsRepository;

  const CrowdActionRepository(
    this._client,
    this._authRepository,
    this._settingsRepository,
  );

  @override
  Future<Either<CrowdActionFailure, CrowdAction>> getCrowdAction(
    String id,
  ) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions/$id',
        ),
      );

      if (response.statusCode == 200) {
        final crowdActionDto = CrowdActionDto.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );
        return right(crowdActionDto.toDomain());
      }

      return left(const CrowdActionFailure.serverError());
    } catch (ex) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdActions({
    int pageNumber = 1,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions?page=$pageNumber',
        ),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final itemsJson = json['items'] as List<dynamic>;
        final pageInfoJson = json['pageInfo'] as Map<String, dynamic>;

        final crowdActions = itemsJson
            .map(
              (item) => CrowdActionDto.fromJson(item as Map<String, dynamic>),
            )
            .toList();

        final pageInfo = PageInfoDto.fromJson(pageInfoJson);

        return right(
          PaginatedCrowdActionsDto(
            crowdActions: crowdActions,
            pageInfo: pageInfo,
          ).toDomain(),
        );
      } else {
        return left(const CrowdActionFailure.serverError());
      }
    } catch (error) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionFailure, Unit>> subscribeToCrowdAction(
    CrowdAction crowdAction,
    List<String> commitments,
    String? password,
  ) async {
    try {
      final user = (await _authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());
      final tokenId = await user.getIdToken();

      final uri = Uri.parse(
        '${await _settingsRepository.baseApiEndpointUrl}/v1/participations',
      );

      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenId'
        },
        body: jsonEncode({
          'crowdActionId': crowdAction.id,
          'password': password,
          'commitmentOptions': commitments
        }),
      );

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(const CrowdActionFailure.networkRequestFailed());
      }
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionFailure, Unit>> unsubscribeFromCrowdAction(
    CrowdAction crowdAction,
  ) async {
    try {
      final user = (await _authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());
      final tokenId = await user.getIdToken();

      final uri = Uri.parse(
        '${await _settingsRepository.baseApiEndpointUrl}/v1/participations',
      );

      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenId'
        },
        body: jsonEncode({
          'crowdActionId': crowdAction.id,
        }),
      );

      if (response.statusCode == 200) {
        return right(unit);
      } else {
        return left(const CrowdActionFailure.networkRequestFailed());
      }
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionFailure, List<CrowdAction>>>
      getSpotlightCrowdActions() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions?status=STARTED&status=WAITING&pageSize=3',
        ),
      );

      final responseBody = jsonDecode(response.body)['items'];
      return right(
        responseBody
            .map<CrowdAction>(
              (json) => CrowdActionDto.fromJson(json as Map<String, dynamic>)
                  .toDomain(),
            )
            .toList() as List<CrowdAction>,
      );
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionFailure, List<CrowdAction>>>
      getCrowdActionsForUser() async {
    // TODO: Implement Pagination
    try {
      final user = (await _authRepository.getSignedInUser()).getOrElse(
        () => throw NotAuthenticatedError(),
      );

      final tokenId = await user.getIdToken();

      final uri = Uri.parse(
        '${await _settingsRepository.baseApiEndpointUrl}/v1/crowdactions/me',
      );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenId'
        },
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        return right(
          responseBody['items']
              .map<CrowdAction>(
                (json) => CrowdActionDto.fromJson(
                  json as Map<String, dynamic>,
                ).toDomain(),
              )
              .toList() as List<CrowdAction>,
        );
      }

      return left(const CrowdActionFailure.networkRequestFailed());
    } catch (_) {
      return left(const CrowdActionFailure.serverError());
    }
  }
}
