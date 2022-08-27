import 'package:collaction_app/domain/crowdaction/participant.dart';
import 'package:dartz/dartz.dart';

import '../profile/user_profile.dart';
import 'profile_failure.dart';

abstract class IProfileRepository {
  Future<Either<ProfileFailure, UserProfile>> getUserProfile();
  Future<Either<ProfileFailure, Unit>> createProfile();
  Future<Either<ProfileFailure, Unit>> saveProfile({
    String? bio,
  });
  Future<Either<ProfileFailure, List<Participant>>> fetchParticipantsProfile({
    required String crowdactionId,
    required int page,
  });
}
