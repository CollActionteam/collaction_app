import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/auth/i_auth_facade.dart';
import 'package:collaction_app/domain/auth/value_objects.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

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
  Stream<Either<AuthFailure, Credential>> verifyPhone(
      {required PhoneNumber phoneNumber}) {
    final result = BehaviorSubject<Either<AuthFailure, Credential>>();
    final phone = phoneNumber.getOrCrash();
    var credential = const Credential();

    firebaseAuth.verifyPhoneNumber(
      phoneNumber: phone,
      codeSent: (String verificationId, int? forceResendingToken) {
        credential = credential.copyWith(
          verificationId: verificationId,
          forceResendToken: forceResendingToken,
        );

        result.add(right(credential));
      },
      verificationFailed: (fb_auth.FirebaseAuthException error) {
        result.add(left(const AuthFailure.verificationFailed()));
        result.close();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        result.close();
      },
      verificationCompleted: (fb_auth.PhoneAuthCredential phoneAuthCredential) {
        credential = credential.copyWith(
          verificationId: phoneAuthCredential.verificationId,
          smsCode: phoneAuthCredential.smsCode,
        );

        result.add(right(credential));
        result.close();
      },
    );

    return result.stream.distinct();
  }
}
