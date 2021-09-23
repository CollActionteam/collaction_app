import 'package:collaction_app/domain/user/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

extension FirebaseUserX on fb_auth.User {
  User toDomain() => User(
        id: uid,
        displayName: displayName,
        phoneNumber: phoneNumber,
        isPhoneNumberVerified: phoneNumber != null,
        email: email,
        isEmailVerified: emailVerified,
        photoURL: photoURL,
        getIdToken: getIdToken,
      );
}
