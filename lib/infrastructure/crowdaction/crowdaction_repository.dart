import 'dart:convert';

import 'package:collaction_app/infrastructure/crowdaction/crowdaction_dto.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../api/queries/crowdaction_queries.dart';
import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/i_crowdaction_repository.dart';

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

      final response = await _client.get(
          Uri.parse('https://api.collaction.org/graphql?query=$query'),
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
}
