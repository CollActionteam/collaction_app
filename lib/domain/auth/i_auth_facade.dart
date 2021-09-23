import 'package:collaction_app/domain/auth/value_objects.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:dartz/dartz.dart';

import 'auth_failures.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();

  Stream<Either<AuthFailure, Credential>> verifyPhone({
    required PhoneNumber phoneNumber,
  });

  Future<void> signOut();
}
