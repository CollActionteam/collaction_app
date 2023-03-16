import 'package:dartz/dartz.dart';

import 'paginated_participations.dart';
import 'participation.dart';
import 'participation_failures.dart';

abstract class IParticipationRepository {
  Future<Either<ParticipationFailure, Participation>> getParticipation({
    required String crowdActionId,
  });

  Future<Either<ParticipationFailure, Unit>> toggleParticipation({
    required String crowdActionId,
    List<String>? commitments,
  });

  Future<Either<ParticipationFailure, PaginatedParticipations>>
      getParticipations({
    required String crowdActionId,
    int pageNumber = 1,
  });

  Future<Either<ParticipationFailure, List<Participation>>> getTopParticipants({
    required String crowdActionId,
  });
}
