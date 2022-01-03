import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  const CrowdActionRepository(this._client, this._authRepository);

  @override
  Future<Either<CrowdActionFailure, List<CrowdAction>>> getCrowdActions({
    int amount = 0,
  }) async {
    try {
      final response = await _client.get(
        Uri.parse('${dotenv.env['BASE_API_ENDPOINT_URL']}/crowdactions'),
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
        '${dotenv.env['BASE_API_ENDPOINT_URL']}/crowdactions/${Uri.encodeComponent(crowdAction.crowdactionID)}/participation',
      );

      final response = await _client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenId'
        },
        body: jsonEncode({'password': password, 'commitments': commitments}),
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
        '${dotenv.env['BASE_API_ENDPOINT_URL']}/crowdactions/${Uri.encodeComponent(crowdAction.crowdactionID)}/participation',
      );

      final response = await _client.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenId'
        },
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
          '${dotenv.env['BASE_API_ENDPOINT_URL']}/crowdactions?status=joinable',
        ),
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
        '${dotenv.env['BASE_API_ENDPOINT_URL']}/crowdactions/${Uri.encodeComponent(crowdAction.crowdactionID)}/participation',
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
            statusData.crowdActionId == crowdAction.crowdactionID &&
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
