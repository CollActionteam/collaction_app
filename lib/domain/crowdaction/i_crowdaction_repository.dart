import 'package:dartz/dartz.dart';

import 'crowdaction.dart';
import 'crowdaction_failures.dart';
import 'paginated_crowdactions.dart';

abstract class ICrowdActionRepository {
  Future<Either<CrowdActionFailure, CrowdAction>> getCrowdAction(
    String id,
  );

  Future<Either<CrowdActionFailure, PaginatedCrowdActions>> getCrowdActions({
    int pageNumber = 1,
  });

  Future<Either<CrowdActionFailure, List<CrowdAction>>>
      getSpotlightCrowdActions();

  Future<Either<CrowdActionFailure, List<CrowdAction>>>
      getCrowdActionsForUser();
}
