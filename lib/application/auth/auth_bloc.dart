import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/user/i_user_repository.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@lazySingleton
class AuthBloc extends Bloc<AuthEvent, AuthState> implements DisposableBloc {
  AuthBloc(this._userRepository) : super(const _Initial());
  StreamSubscription? _credentialStreamSubscription;
  final IUserRepository _userRepository;
  String? _verificationId;

  Stream<AuthState> _mapErrorToState(Exception error) async* {
    yield AuthState.authError(error);
  }

  Stream<AuthState> _mapResetToState() async* {
    _credentialStreamSubscription?.cancel();
    _verificationId = null;
    yield const _Initial();
  }

  Stream<AuthState> _mapRegisterPhoneNumberToState(String phoneNumber) async* {
    _credentialStreamSubscription?.cancel();
    _credentialStreamSubscription =
        _userRepository.registerPhoneNumber(phoneNumber).listen((credential) {
      add(AuthEvent.updated(credential));
    }, onError: (e) {
      add(AuthEvent.error(e is Exception ? e : Exception(e)));
      _credentialStreamSubscription?.cancel();
    });
    yield const AuthState.registeringPhoneNumber();
  }

  Stream<AuthState> _mapUpdatedToState(Credential credential) async* {
    yield const AuthState.awaitingVerification();
    if (credential.verificationId != null) {
      _verificationId = credential.verificationId;
    }
    if (credential.smsCode != null) {
      add(AuthEvent.verify(credential.smsCode!));
    }
  }

  Stream<AuthState> _mapVerifyToState(String smsCode) async* {
    if (_verificationId == null) {
      yield AuthState.authError(
          AuthException(message: 'Verification id is null'));
    } else {
      yield AuthState.verifying(smsCode);
      _userRepository.signIn(Credential(verificationId:_verificationId, smsCode:smsCode)).then(
          (result) {
        add(AuthEvent.logIn(isNewUser: result.isNewUser));
      }, onError: (e) {
        add(AuthEvent.error(e is Exception ? e : Exception(e)));
      });
    }
  }

  Stream<AuthState> _mapLogInToState(bool isNewUser) async* {
    _credentialStreamSubscription?.cancel();
    yield AuthState.loggedIn(isNewUser: isNewUser);
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.when(
        error: _mapErrorToState,
        reset: _mapResetToState,
        registerPhoneNumber: _mapRegisterPhoneNumberToState,
        updated: _mapUpdatedToState,
        verify: _mapVerifyToState,
        logIn: _mapLogInToState);
  }

  @override
  void dispose() {
    _credentialStreamSubscription?.cancel();
  }
}

abstract class DisposableBloc {
  void dispose();
}
