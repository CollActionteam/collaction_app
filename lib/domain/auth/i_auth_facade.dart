import 'dart:io';

import 'package:collaction_app/domain/auth/auth_event.dart';
import 'package:collaction_app/domain/auth/value_objects.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:dartz/dartz.dart';

import 'auth_failures.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();

  Stream<Either<AuthFailure, AuthEvent>> verifyPhone({
    required PhoneNumber phoneNumber,
  });

  Future<Either<AuthFailure, Unit>> signInWithPhone(
      {required Credential authCredentials});

  Future<Either<AuthFailure, Unit>> updateUsername({required String username});

  Future<Either<AuthFailure, Unit>> updatePhoto({required File photo});

  Future<void> signOut();
}
