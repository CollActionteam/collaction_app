import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/crowdaction_failures.dart';
import '../../domain/crowdaction/i_crowdaction_repository.dart';
import '../../presentation/crowd_action/utils/dummies.dart';
import 'crowdaction_dto.dart';

@LazySingleton(as: ICrowdActionRepository)
class CrowdActionRepository implements ICrowdActionRepository {
  /// TODO: Reevaluate usage on API implementation
  final http.Client _client;
  const CrowdActionRepository(this._client);

  @override
  Future<List<CrowdAction>> getCrowdActions({int amount = 0}) async {
    try {
      /// TODO: Reevaluate usage on API implementation
      // final query = amount > 0
      //     ? queryGetFixedCrowdActions.replaceAll(placeholder, amount.toString())
      //     : queryGetCrowdActions;

      final response = await _client.get(
          Uri.parse('https://api-dev.collaction.org/crowdactions?status=joinable'),
          headers: {'Content-Type': 'application/json'});

      final responseBody = CrowdActionList.fromJson(
          json.decode(response.body)['data'] as Map<String, dynamic>);

      return responseBody.crowdactions
          .map((crowdActionDto) => crowdActionDto.toDomain())
          .toList();
    } catch (error) {
      print(error);
      return <CrowdAction>[];
    }
  }

  @override
  Future<Either<CrowdActionFailure, Unit>> subscribeToCrowdAction(
      CrowdAction crowdAction) async {
    try {
      // TODO - Subscribe to crowd action
      await Future.delayed(const Duration(seconds: 3));
      return right(unit);
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionFailure, Unit>> unsubscribeFromCrowdAction(
      CrowdAction crowdAction) async {
    try {
      // TODO - Subscribe to crowd action
      await Future.delayed(const Duration(seconds: 3));
      return right(unit);
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }

  @override
  Future<Either<CrowdActionFailure, List<CrowdAction>>>
      getSpotlightCrowdActions() async {
    try {
      final uri = Uri.parse('https://api-dev.collaction.org/crowdactions?status=joinable');
      final response = await _client.get(uri, headers: {'Content-Type': 'application/json'});

      final responseBody = CrowdActionList.fromJson(
          json.decode(response.body)['data'] as Map<String, dynamic>);

      return right(responseBody.crowdactions
          .map((crowdActionDto) => crowdActionDto.toDomain())
          .toList());
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }
}
