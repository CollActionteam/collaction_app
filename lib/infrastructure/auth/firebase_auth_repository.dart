import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/auth_success.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/user/i_user_repository.dart';
import '../../domain/user/user.dart';
import 'firebase_auth_mapper.dart';

@LazySingleton(as: IAuthRepository)
class FirebaseAuthRepository implements IAuthRepository, Disposable {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final _userSubject = BehaviorSubject<User>.seeded(User.anonymous);
  late final StreamSubscription _userStreamSubscription;

  FirebaseAuthRepository({required this.firebaseAuth}) {
    _userStreamSubscription = firebaseAuth
        .authStateChanges()
        .map(_firebaseUserToUser)
        .listen(_userSubject.sink.add);
  }

  @override
  Future<Option<User>> getSignedInUser() async {
    return optionOf(firebaseAuth.currentUser?.toDomain());
  }

  @override
  Future<void> signOut() => firebaseAuth.signOut();

  @override
  Stream<Either<AuthFailure, AuthSuccess>> verifyPhone({
    required String phoneNumber,
  }) {
    final result = StreamController<Either<AuthFailure, AuthSuccess>>();

    Credential credential = const Credential();

    firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+$phoneNumber",
      codeSent: (String verificationId, int? forceResendingToken) {
        credential = credential.copyWith(
          verificationId: verificationId,
          forceResendToken: forceResendingToken,
        );

        result.add(right(AuthSuccess.codeSent(credential: credential)));
      },
      verificationFailed: (firebase_auth.FirebaseAuthException error) {
        result.add(left(error.toFailure()));
        result.close();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        result.add(
          right(
            AuthSuccess.codeRetrievalTimedOut(
              credential: credential.copyWith(verificationId: verificationId),
            ),
          ),
        );
        result.close();
      },
      verificationCompleted:
          (firebase_auth.PhoneAuthCredential phoneAuthCredential) {
        credential = credential.copyWith(
          verificationId: phoneAuthCredential.verificationId,
          smsCode: phoneAuthCredential.smsCode,
        );

        result.add(
          right(AuthSuccess.verificationCompleted(credential: credential)),
        );
        result.close();
      },
    );

    return result.stream.distinct();
  }

  @override
  Future<Either<AuthFailure, bool>> signInWithPhone({
    required Credential authCredentials,
  }) async {
    try {
      final String verificationId = authCredentials.verificationId!;
      final String smsCode = authCredentials.smsCode!;
      // Create a PhoneAuthCredential with the code
      final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // Sign the user in (or link) with the credential
      final authResult = await firebaseAuth.signInWithCredential(credential);

      // Check if is new user
      return right(authResult.additionalUserInfo?.isNewUser == true);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updateUsername({
    required String firstname,
    required String lastname,
  }) async {
    try {
      final user = firebaseAuth.currentUser!;
      final String username = firstname + ' ' + lastname;
      await user.updateDisplayName(username);

      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> updatePhoto({required File photo}) async {
    try {
      // TODO Upload photo to storage
      // final String profileUrl = throw UnimplementedError("Upload photo to storage");

      // final user = firebaseAuth.currentUser!;
      // await user.updatePhotoURL(profileUrl);
      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (error) {
      return left(error.toFailure());
    } catch (_) {
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Stream<Either<AuthFailure, AuthSuccess>> resendOTP({
    required String phoneNumber,
    required Credential authCredentials,
  }) {
    final result = StreamController<Either<AuthFailure, AuthSuccess>>();

    Credential credential = const Credential();

    firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+$phoneNumber",
      forceResendingToken: authCredentials.forceResendToken,
      codeSent: (String verificationId, int? forceResendingToken) async {
        credential = credential.copyWith(
          verificationId: verificationId,
          forceResendToken: forceResendingToken,
        );

        result.add(right(AuthSuccess.codeSent(credential: credential)));
      },
      verificationFailed: (firebase_auth.FirebaseAuthException error) {
        result.add(left(error.toFailure()));
        result.close();
      },
      codeAutoRetrievalTimeout: (String verificationId) async {
        credential = credential.copyWith(verificationId: verificationId);

        result.add(
          right(AuthSuccess.codeRetrievalTimedOut(credential: credential)),
        );
        result.close();
      },
      verificationCompleted:
          (firebase_auth.PhoneAuthCredential phoneAuthCredential) async {
        credential = credential.copyWith(
          verificationId: phoneAuthCredential.verificationId,
          smsCode: phoneAuthCredential.smsCode,
        );

        result.add(
          right(AuthSuccess.verificationCompleted(credential: credential)),
        );
        result.close();
      },
    );

    return result.stream.distinct();
  }

  static User _firebaseUserToUser(firebase_auth.User? firebaseUser) {
    if (firebaseUser == null || firebaseUser.isAnonymous) {
      return User.anonymous;
    } else {
      return User(
        id: firebaseUser.uid,
        firstname: firebaseUser.displayName,
        phoneNumber: firebaseUser.phoneNumber,
        isPhoneNumberVerified: firebaseUser.phoneNumber != null,
        email: firebaseUser.email,
        isEmailVerified: firebaseUser.emailVerified,
        photoURL: firebaseUser.photoURL,
        getIdToken: firebaseUser.getIdToken,
      );
    }
  }

  @override
  Stream<User> observeUser() => _userSubject.stream.distinct();

  @override
  FutureOr onDispose() {
    _userStreamSubscription.cancel();
    _userSubject.close();
  }
}
