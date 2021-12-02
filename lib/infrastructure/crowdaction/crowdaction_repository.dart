import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/crowdaction/crowdaction.dart';
import '../../domain/crowdaction/crowdaction_failures.dart';
import '../../domain/crowdaction/i_crowdaction_repository.dart';
import '../../presentation/crowd_action/utils/dummies.dart';

@LazySingleton(as: ICrowdActionRepository)
class CrowdActionRepository implements ICrowdActionRepository {
  /// TODO: Reevaluate usage on API implementation
  // final http.Client _client;
  const CrowdActionRepository();

  @override
  Future<List<CrowdAction>> getCrowdActions({int amount = 0}) async {
    try {
      /// TODO: Reevaluate usage on API implementation
      // final query = amount > 0
      //     ? queryGetFixedCrowdActions.replaceAll(placeholder, amount.toString())
      //     : queryGetCrowdActions;

      final response =
          await Future.delayed(const Duration(seconds: 5)).then((_) => [
                CrowdAction(
                  image: 'https://i.imgur.com/kwV7YF6.png',
                  name:
                      'This is the headline for the crowdaction by Guru Saksham',
                  description:
                      'Here comes the description of the shown crowdaction',
                  start: DateTime.now(),
                  end: DateTime.now(),
                  numParticipants: 3,
                ),
                CrowdAction(
                  image: 'https://i.imgur.com/kwV7YF6.png',
                  name:
                      'This is the headline for the crowdaction by Guru Isaac',
                  description:
                      'Here comes the description of the shown crowdaction',
                  start: DateTime.now(),
                  end: DateTime.now(),
                  numParticipants: 3,
                ),
                CrowdAction(
                  image: 'https://i.imgur.com/kwV7YF6.png',
                  name: 'This is the headline for the crowdaction by Guru Yash',
                  description:
                      'Here comes the description of the shown crowdaction',
                  start: DateTime.now(),
                  end: DateTime.now(),
                  numParticipants: 3,
                ),
                CrowdAction(
                  image: 'https://i.imgur.com/kwV7YF6.png',
                  name:
                      'This is the headline for the crowdaction by Guru Lorenzo',
                  description:
                      'Here comes the description of the shown crowdaction',
                  start: DateTime.now(),
                  end: DateTime.now(),
                  numParticipants: 3,
                ),
                CrowdAction(
                  image: 'https://i.imgur.com/kwV7YF6.png',
                  name: 'This is the headline for the crowdaction by Guru Tom',
                  description:
                      'Here comes the description of the shown crowdaction',
                  start: DateTime.now(),
                  end: DateTime.now(),
                  numParticipants: 3,
                ),
              ]);

      return response.take(amount).toList();

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
  Future<Either<CrowdActionFailure, Unit>> unsubscribeToCrowdAction(
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
