import 'package:dartz/dartz.dart';

import '../user/i_user_repository.dart';
import '../user/user.dart';
import 'auth_failures.dart';
import 'auth_success.dart';

abstract class IAuthRepository {
  Stream<User?> observeUser();

  /// TODO - Choose to either observe or getSignedInUser
  /// Returns [User] if already authenticated
  ///  or [none] if not authenticated
  Future<Option<User>> getSignedInUser();

  /// Listens for phone validation [Stream]
  ///
  /// It can either be an [AuthFailure] when an error occurs
  /// or an [AuthEvent] if successful, the event contains
  /// a [Credential]
  Stream<Either<AuthFailure, AuthSuccess>> verifyPhone({
    required String phoneNumber,
  });

  /// Listens for phone validation [Stream]
  ///
  /// It can either be an [AuthFailure] when an error occurs
  /// or an [AuthEvent] if successful, the event contains
  /// a [Credential]
  Stream<Either<AuthFailure, AuthSuccess>> resendOTP({
    required String phoneNumber,
    required Credential authCredentials,
  });

  /// When an SMS code is provided, this completes the authentication
  ///
  /// It can either be an [AuthFailure] when an error occurs
  /// or a [bool] that signifies if a user is new or existing.
  Future<Either<AuthFailure, bool>> signInWithPhone({
    required Credential authCredentials,
  });

  /// Update the user's [username] in the profile
  ///
  /// It can either be an [AuthFailure] when an error occurs
  /// or a [Unit] when successful.
  Future<Either<AuthFailure, Unit>> updateUsername({required String username});

  /// Sign out of the user's account
  Future<void> signOut();
}
