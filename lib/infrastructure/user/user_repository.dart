import 'dart:async';

import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository, Disposable {
  late final firebase_auth.FirebaseAuth _firebaseAuth;
  final _userSubject = BehaviorSubject<User>.seeded(User.anonymous);
  late final StreamSubscription _userStreamSubscription;

  UserRepository({required firebase_auth.FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth {
    _userStreamSubscription = _firebaseAuth
        .authStateChanges()
        .map(_firebaseUserToUser)
        .listen(_userSubject.sink.add);
  }

  static User _firebaseUserToUser(firebase_auth.User? firebaseUser) {
    if (firebaseUser == null || firebaseUser.isAnonymous) {
      return User.anonymous;
    } else {
      return User(
        id: firebaseUser.uid,
        displayName: firebaseUser.displayName,
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
  Stream<Credential> registerPhoneNumber(String phoneNumber) {
    final result = BehaviorSubject<Credential>();
    _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {
          result.add(Credential(
              credential.verificationId ?? result.valueOrNull?.verificationId,
              credential.smsCode));
          result.close();
        },
        verificationFailed: (firebase_auth.FirebaseAuthException error) {
          result.addError(AuthException(message: error.message));
          result.close();
        },
        codeSent: (verificationId, resendToken) {
          result.add(Credential(verificationId, null));
        },
        codeAutoRetrievalTimeout: (_) => result.close());
    return result.stream.distinct((a, b) =>
        a.verificationId == b.verificationId &&
        a.smsCode == b.smsCode); // Avoid sending same credential twice
  }

  @override
  Future<SignInResult> signIn(Credential credential) async {
    assert(credential.verificationId != null);
    assert(credential.smsCode != null);
    final firebaseCredential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: credential.verificationId!,
        smsCode: credential.smsCode!);
    final userCredential = await _firebaseAuth
        .signInWithCredential(firebaseCredential)
        .onError<firebase_auth.FirebaseAuthException>(
            (error, stackTrace) => throw AuthException(message: error.message));
    final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
    return SignInResult(isNewUser: isNewUser);
  }

  @override
  FutureOr onDispose() {
    _userStreamSubscription.cancel();
    _userSubject.close();
  }
}
