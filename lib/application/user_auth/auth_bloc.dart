import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> implements DisposableBloc {
  AuthBloc(this._userRepository) : super(const _Initial());
  StreamSubscription? _credentialStreamSubscription;
  final IUserRepository _userRepository;
  String? verificationId;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.when(error: (e) async* {
      yield AuthState.authError(e);
    }, reset: () async* {
      _credentialStreamSubscription?.cancel();
      yield const _Initial();
    }, registerPhoneNumber: (phoneNumber) async* {
      _credentialStreamSubscription?.cancel();
      _credentialStreamSubscription =
          _userRepository.registerPhoneNumber(phoneNumber).listen((credential) {
        add(AuthEvent.updated(credential));
      }, onError: (e) {
        add(AuthEvent.error(e is Exception ? e : Exception(e)));
        _credentialStreamSubscription?.cancel();
      });
      yield const AuthState.registeringPhoneNumber();
    }, updated: (credential) async* {
      yield const AuthState.awaitingVerification();
      if (credential.verificationId != null) {
        verificationId = credential.verificationId;
      }
      if (credential.smsCode != null) {
        add(AuthEvent.verify(credential.smsCode!));
      }
    }, verify: (smsCode) async* {
      if (verificationId == null) {
        yield AuthState.authError(
            AuthException(message: 'Verification id is null'));
      } else {
        yield AuthState.verifying(smsCode);
        _userRepository.signIn(Credential(verificationId, smsCode)).then(
            (result) {
          add(AuthEvent.logIn(isNewUser: result.isNewUser));
        }, onError: (e) {
          add(AuthEvent.error(e is Exception ? e : Exception(e)));
        });
      }
    }, logIn: (isNewUser) async* {
      _credentialStreamSubscription?.cancel();
      yield AuthState.loggedIn(isNewUser: isNewUser);
    });
  }

  @override
  void dispose() {
    _credentialStreamSubscription?.cancel();
  }
}

abstract class DisposableBloc {
  void dispose();
}