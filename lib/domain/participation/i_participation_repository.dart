import 'package:collaction_app/domain/participation/participation.dart';
import 'package:collaction_app/domain/participation/participation_failures.dart';
import 'package:dartz/dartz.dart';

abstract class IParticipationRepository {
  Future<Either<ParticipationFailure, Participation>> getParticipation({
    required String crowdActionId,
  });

  Future<Either<ParticipationFailure, Unit>> toggleParticipation({
    required String crowdActionId,
    List<String>? commitmentOptions,
  });
}
