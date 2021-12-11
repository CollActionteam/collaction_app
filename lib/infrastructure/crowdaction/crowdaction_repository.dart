import 'dart:convert';

import 'package:collaction_app/domain/crowdaction/crowdaction_status.dart';
import 'package:collaction_app/infrastructure/crowdaction/crowdaction_status_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/crowdaction_failures.dart';
import '../../domain/crowdaction/i_crowdaction_repository.dart';
import 'crowdaction_dto.dart';

@LazySingleton(as: ICrowdActionRepository)
class CrowdActionRepository implements ICrowdActionRepository {
  /// TODO: Reevaluate usage on API implementation
  final http.Client _client;
  final FirebaseAuth _auth;

  const CrowdActionRepository(this._client, this._auth);

  @override
  Future<List<CrowdAction>> getCrowdActions({int amount = 0}) async {
    try {
      /// TODO: Reevaluate usage on API implementation
      // final query = amount > 0
      //     ? queryGetFixedCrowdActions.replaceAll(placeholder, amount.toString())
      //     : queryGetCrowdActions;

      final response = await _client.get(
          Uri.parse(
              'https://api-dev.collaction.org/crowdactions?status=joinable'),
          headers: {'Content-Type': 'application/json'});

      final responseBody = CrowdActionList.fromJson(
          json.decode(response.body)['data'] as Map<String, dynamic>);

      return responseBody.crowdactions
          .map((crowdActionDto) => crowdActionDto.toDomain())
          .toList();
    } catch (error) {
      return <CrowdAction>[];
    }
  }

  @override
  Future<Either<CrowdActionFailure, Unit>> subscribeToCrowdAction(
      CrowdAction crowdAction,
      List<String> commitments,
      String? password) async {
    try {
      final tokenId = await _auth.currentUser!.getIdToken();

      final uri = Uri.parse(
          '${dotenv.env['BASE_API_ENDPOINT_URL']}crowdactions/${Uri.encodeComponent(crowdAction.crowdActionId)}/participation');

      final response = await _client.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $tokenId'
          },
          body: jsonEncode({'password': password, 'commitments': commitments}));

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
      CrowdAction crowdAction) async {
    try {
      final tokenId = await _auth.currentUser!.getIdToken();

      final uri = Uri.parse(
          '${dotenv.env['BASE_API_ENDPOINT_URL']}crowdactions/${Uri.encodeComponent(crowdAction.crowdActionId)}/participation');

      final response = await _client.delete(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenId'
      });

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
      final uri = Uri.parse(
          '${dotenv.env['BASE_API_ENDPOINT_URL']}crowdactions?status=joinable');
      final response =
          await _client.get(uri, headers: {'Content-Type': 'application/json'});

      final actions = (jsonDecode(response.body) as List<dynamic>)
          .map((e) =>
              CrowdActionDto.fromJson(e as Map<String, dynamic>).toDomain())
          .toList();

      return right(actions);
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionFailure, CrowdActionStatus>>
      checkCrowdActionSubscriptionStatus(CrowdAction crowdAction) async {
    try {
      final tokenId = await _auth.currentUser!.getIdToken();

      final uri = Uri.parse(
          '${dotenv.env['BASE_API_ENDPOINT_URL']}crowdactions/${Uri.encodeComponent(crowdAction.crowdActionId)}/participation');

      final response = await _client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenId'
      });

      if (response.statusCode == 200) {
        final status = jsonDecode(response.body) as Map<String, dynamic>;
        final statusData = CrowdActionStatusDto.fromJson(status);
        if (statusData.userId == _auth.currentUser?.uid &&
            statusData.crowdActionId == crowdAction.crowdActionId &&
            statusData.commitments.isNotEmpty) {
          return right(CrowdActionStatus.subscribed(
              statusData.commitments.toSet().toList()));
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
