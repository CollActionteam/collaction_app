import 'package:dartz/dartz.dart';

import '../profile/profile.dart';
import '../profile/user_profile.dart';
import 'profile_failure.dart';

abstract class IProfileRepository {
  Future<Either<ProfileFailure, UserProfile>> getUserProfile();

  Stream<Either<ProfileFailure, Profile>> getUserProfileById(String userId);

  Future<Either<ProfileFailure, Unit>> createProfile();

  Future<Either<ProfileFailure, Unit>> saveProfile({
    String? bio,
  });
}
