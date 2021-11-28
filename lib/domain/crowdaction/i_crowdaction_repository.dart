import 'package:dartz/dartz.dart';

import 'crowdaction.dart';
import 'crowdaction_failures.dart';

abstract class ICrowdActionRepository {
  Future<List<CrowdAction>> getCrowdActions({int amount = 0});
  Future<Either<CrowdActionFailure,List<CrowdAction>>> getSpotLightCrowdActions();

  Future<Either<CrowdActionFailure,Unit>> subscribeToCrowdAction(CrowdAction crowdAction);
}
