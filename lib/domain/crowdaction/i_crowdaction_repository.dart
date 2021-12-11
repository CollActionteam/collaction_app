import 'package:dartz/dartz.dart';

import 'crowdaction.dart';
import 'crowdaction_failures.dart';

abstract class ICrowdActionRepository {
  Future<Either<CrowdActionFailure, List<CrowdAction>>> getCrowdActions(
      {int amount = 0});
  Future<Either<CrowdActionFailure, List<CrowdAction>>>
      getSpotlightCrowdActions();

  Future<Either<CrowdActionFailure, Unit>> subscribeToCrowdAction(
      CrowdAction crowdAction);

  Future<Either<CrowdActionFailure, Unit>> unsubscribeFromCrowdAction(
      CrowdAction crowdAction);
}
