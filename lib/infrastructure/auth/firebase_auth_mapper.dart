import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

extension FirebaseUserX on fb_auth.User? {
  User toDomain() {
    if (this == null) {
      return User.anonymous;
    } else {
      return User(
        id: this!.uid,
        displayName: this?.displayName,
        phoneNumber: this?.phoneNumber,
        isPhoneNumberVerified: this?.phoneNumber != null,
        email: this?.email,
        isEmailVerified: this!.emailVerified,
        photoURL: this?.photoURL,
        getIdToken: this!.getIdToken,
      );
    }
  }
}

extension FirebaseErrorX on fb_auth.FirebaseAuthException {
  AuthFailure toFailure() {
    if (code == 'network-request-failed') {
      return const AuthFailure.networkRequestFailed();
    } else if (code == 'invalid-phone-number') {
      return const AuthFailure.invalidPhone();
    } else if (code == 'invalid-verification-code') {
      return const AuthFailure.invalidSmsCode();
    } else {
      return const AuthFailure.serverError();
    }
  }
}
