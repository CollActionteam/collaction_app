import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:injectable/injectable.dart';

import '../../domain/auth/auth_event.dart';
import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/i_auth_facade.dart';
import '../../domain/user/i_user_repository.dart';
import '../../domain/user/user.dart';
import 'firebase_auth_mapper.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final fb_auth.FirebaseAuth firebaseAuth;

  const FirebaseAuthFacade({required this.firebaseAuth});

  @override
  Future<Option<User>> getSignedInUser() async {
    return optionOf(firebaseAuth.currentUser?.toDomain());
  }

  @override
  Future<void> signOut() => firebaseAuth.signOut();

  @override
  Stream<Either<AuthFailure, AuthEvent>> verifyPhone(
      {required String phoneNumber}) {
    final result = StreamController<Either<AuthFailure, AuthEvent>>();

    var credential = const Credential();

    firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+$phoneNumber",
      codeSent: (String verificationId, int? forceResendingToken) {
        credential = credential.copyWith(
          verificationId: verificationId,
          forceResendToken: forceResendingToken,
        );

        result.add(right(AuthEvent.codeSent(credential: credential)));
      },
      verificationFailed: (fb_auth.FirebaseAuthException error) {
        result.add(left(error.toFailure()));
        result.close();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        result.add(
            right(AuthEvent.codeRetrievalTimedOut(credential: credential)));
        result.close();
      },
      verificationCompleted: (fb_auth.PhoneAuthCredential phoneAuthCredential) {
        credential = credential.copyWith(
          verificationId: phoneAuthCredential.verificationId,
          smsCode: phoneAuthCredential.smsCode,
        );

        result.add(
            right(AuthEvent.verificationCompleted(credential: credential)));
        result.close();
      },
    );

    return result.stream.distinct();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithPhone({required Credential authCredentials}) async {
    try {
      final String verificationId = authCredentials.verificationId!;
      final String smsCode = authCredentials.smsCode!;
      // Create a PhoneAuthCredential with the code
      final credential = fb_auth.PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      // Sign the user in (or link) with the credential
      await firebaseAuth.signInWithCredential(credential);
      return right(unit);
    } on fb_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateUsername({required String username}) async {
    try {
      final user = firebaseAuth.currentUser!;
      await user.updateDisplayName(username);

      return right(unit);
    } on fb_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updatePhoto({required File photo}) async {
    try {
      // TODO Upload photo to storage
      final String profileUrl =
      throw UnimplementedError("Upload photo to storage");

      final user = firebaseAuth.currentUser!;
      await user.updatePhotoURL(profileUrl);
      return right(unit);
    } on fb_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }
}
