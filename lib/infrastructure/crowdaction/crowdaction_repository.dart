import 'dart:convert';

import 'package:collaction_app/domain/crowdaction/crowdaction_failures.dart';
import 'package:collaction_app/presentation/crowd_action/utils/dummies.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../api/queries/crowdaction_queries.dart';
import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/i_crowdaction_repository.dart';
import 'crowdaction_dto.dart';

@LazySingleton(as: ICrowdActionRepository)
class CrowdActionRepository implements ICrowdActionRepository {
  final http.Client _client;

  CrowdActionRepository(this._client);

  @override
  Future<List<CrowdAction>> getCrowdActions({int amount = 0}) async {
    try {
      final query = amount > 0
          ? queryGetFixedCrowdActions.replaceAll(placeholder, amount.toString())
          : queryGetCrowdActions;

      final response = Future.delayed(const Duration(seconds: 5)).then((_) => [
            CrowdAction(
              image: 'assets/images/ocean.png',
              name: 'This is the headline for the crowdaction by Guru Saksham',
              description:
                  'Here comes the description of the shown crowdaction',
              start: DateTime.now(),
              end: DateTime.now(),
              numParticipants: 3,
            ),
            CrowdAction(
              image: 'assets/images/ocean.png',
              name: 'This is the headline for the crowdaction by Guru Isaac',
              description:
                  'Here comes the description of the shown crowdaction',
              start: DateTime.now(),
              end: DateTime.now(),
              numParticipants: 3,
            ),
            CrowdAction(
              image: 'assets/images/ocean.png',
              name: 'This is the headline for the crowdaction by Guru Yash',
              description:
                  'Here comes the description of the shown crowdaction',
              start: DateTime.now(),
              end: DateTime.now(),
              numParticipants: 3,
            ),
            CrowdAction(
              image: 'assets/images/ocean.png',
              name: 'This is the headline for the crowdaction by Guru Lorenzo',
              description:
                  'Here comes the description of the shown crowdaction',
              start: DateTime.now(),
              end: DateTime.now(),
              numParticipants: 3,
            ),
            CrowdAction(
              image: 'assets/images/ocean.png',
              name: 'This is the headline for the crowdaction by Guru Tom',
              description:
                  'Here comes the description of the shown crowdaction',
              start: DateTime.now(),
              end: DateTime.now(),
              numParticipants: 3,
            ),
          ]);

      return response;

      // final response = await _client.get(
      //     Uri.parse('https://api.collaction.org/graphql?query=$query'),
      //     headers: {'Content-Type': 'application/json'});

      // final responseBody = CrowdActionList.fromJson(
      //     json.decode(response.body)['data'] as Map<String, dynamic>);

      // return responseBody.crowdactions
      //     .map((crowdActionDto) => crowdActionDto.toDomain())
      //     .toList();
    } catch (error) {
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
  Future<Either<CrowdActionFailure, List<CrowdAction>>>
      getSpotLightCrowdActions() async {
    try {
      // TODO - pick spotlight crowd actions from API
      await Future.delayed(const Duration(seconds: 3));
      return right(crowdActionSpotlightDummies);
    } catch (e) {
      return left(const CrowdActionFailure.networkRequestFailed());
    }
  }
}
