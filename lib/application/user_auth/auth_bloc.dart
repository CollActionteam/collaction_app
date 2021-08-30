import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState>
    implements DisposableBloc {
  AuthBlocBloc() : super(const _Initial());
  Stream<Credential>? credentialStream;
  StreamSubscription? _credentialStreamSubscription;

  @override
  Stream<AuthBlocState> mapEventToState(
    AuthBlocEvent event,
  ) async* {
    yield* event.when(confirmCode: (String code) async* {
      yield const AuthBlocState.watching();
      _watchCredentials(code);
    }, updated: (Credential credential, String code) async* {
      // Handle The update
    });
  }

  void _watchCredentials(String code) {
    _credentialStreamSubscription?.cancel();
    _credentialStreamSubscription = credentialStream!
        .listen((credential) => add(AuthBlocEvent.updated(credential, code)));
  }

  @override
  void dispose() {
    _credentialStreamSubscription?.cancel();
  }
}

abstract class DisposableBloc {
  void dispose();
}
