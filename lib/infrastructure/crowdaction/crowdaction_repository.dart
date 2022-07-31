import 'dart:convert';

import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/auth/errors.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/crowdaction_failures.dart';
import '../../domain/crowdaction/crowdaction_status.dart';
import '../../domain/crowdaction/i_crowdaction_repository.dart';
import 'crowdaction_dto.dart';
import 'crowdaction_status_dto.dart';

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
  Future<Either<CrowdActionFailure, List<CrowdAction>>> getCrowdActions({
    int amount = 0,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse(
          '${await _settingsRepository.baseApiEndpointUrl}/v1/api/crowdactions',
        ),
        headers: {'Content-Type': 'application/json'},
      );

      final responseBody = jsonDecode(response.body);
      return right(
        responseBody
            .map<CrowdAction>(
              (json) => CrowdActionDto.fromJson(json as Map<String, dynamic>)
                  .toDomain(),
            )
            .toList() as List<CrowdAction>,
      );
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
        '${await _settingsRepository.baseApiEndpointUrl}/api/v1/participations',
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
        '${await _settingsRepository.baseApiEndpointUrl}/api/v1/participations',
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
          '${await _settingsRepository.baseApiEndpointUrl}/api/v1/crowdactions?status=STARTED&status=WAITING&pageSize=3',
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
  Future<Either<CrowdActionFailure, CrowdActionStatus>>
      checkCrowdActionSubscriptionStatus(CrowdAction crowdAction) async {
    try {
      final user = (await _authRepository.getSignedInUser())
          .getOrElse(() => throw NotAuthenticatedError());
      final tokenId = await user.getIdToken();

      final uri = Uri.parse(
        '${await _settingsRepository.baseApiEndpointUrl}/api/v1/participations/${Uri.encodeComponent(crowdAction.id)}',
      );

      final response = await _client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenId'
        },
      );

      if (response.statusCode == 200) {
        final status = jsonDecode(response.body) as Map<String, dynamic>;
        final statusData = CrowdActionStatusDto.fromJson(status);
        if (statusData.userId == user.id &&
            statusData.crowdActionId == crowdAction.id &&
            statusData.commitments.isNotEmpty) {
          return right(
            CrowdActionStatus.subscribed(
              statusData.commitments.toSet().toList(),
            ),
          );
        } else {
          throw Exception("Invalid Status");
        }
      }

      return right(const CrowdActionStatus.notSubscribed());
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }
}
