import 'package:dartz/dartz.dart';

import '../core/location.dart';
import '../profile/user_profile.dart';
import 'profile_failure.dart';

abstract class IProfileRepository {
  Future<Either<ProfileFailure, UserProfile>> getUserProfile();
  Future<Either<ProfileFailure, Unit>> createProfile();
  Future<Either<ProfileFailure, Unit>> saveProfile({
    String? bio,
  });
  Future<Either<ProfileFailure, Unit>> updateUsername({
    String? firstName,
    String? lastName,
  });
  Future<Either<ProfileFailure, Unit>> updateCountry({
    String? countryCode,
  });
}
