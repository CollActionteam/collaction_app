import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/auth/auth_failures.dart';
import '../../domain/auth/auth_success.dart';
import '../../domain/auth/i_auth_repository.dart';
import '../../domain/user/i_avatar_repository.dart';
import '../../domain/user/i_user_repository.dart';
import '../../domain/user/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  final IAvatarRepository _avatarRepository;

  Credential? _credential;
  String? _phone;
  StreamSubscription<Either<AuthFailure, AuthSuccess>>?
      _verifyStreamSubscription;
  StreamSubscription? _authenticationStateSubscription;

  AuthBloc(
    this._authRepository,
    this._avatarRepository,
  ) : super(const AuthState.initial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is _InitialEvent) {
          await _mapObserveUserToState(emit, event);
        } else if (event is _VerifyPhone) {
          await _mapVerifyPhoneToState(emit, event);
        } else if (event is _SignInWithPhone) {
          await _mapSignInWithPhoneToState(emit, event);
        } else if (event is _Updated) {
          await _mapUpdatedToState(emit, event);
        } else if (event is _Reset) {
          await _mapResetToState(emit, event);
        } else if (event is _AuthCheckRequested) {
          await _mapAuthCheckRequestToState(emit, event);
        } else if (event is _SignedOut) {
          await _mapSignOutToState(emit, event);
        } else if (event is _UpdateProfilePhoto) {
          await _mapUpdateProfilePhotoToState(emit, event);
        } else if (event is _ResendCode) {
          await _mapResendCodeToState(emit, event);
        }
      },
    );
  }

  Future<void> _mapObserveUserToState(
    Emitter<AuthState> emit,
    _InitialEvent event,
  ) async {
    _authenticationStateSubscription =
        _authRepository.observeUser().listen((event) {
      if (event is User && event.isAnonymous) {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  FutureOr<void> _mapResendCodeToState(
    Emitter<AuthState> emit,
    _ResendCode event,
  ) async {
    emit(const AuthState.awaitingCodeResend());

    _verifyStreamSubscription = _authRepository
        .resendOTP(phoneNumber: _phone!, authCredentials: _credential!)
        .listen(
          (failureOrCredential) => add(AuthEvent.updated(failureOrCredential)),
        );
  }

  FutureOr<void> _mapUpdateProfilePhotoToState(
    Emitter<AuthState> emit,
    _UpdateProfilePhoto event,
  ) async {
    emit(const AuthState.awaitingPhotoUpdate());

    final failureOrSuccess = await _avatarRepository.uploadAvatar(event.photo);

    emit(
      failureOrSuccess.fold(
        (failure) => AuthState.authError(AuthFailure.networkRequestFailed()),
        (_) => const AuthState.photoUpdateDone(),
      ),
    );
  }

  FutureOr<void> _mapSignOutToState(
    Emitter<AuthState> emit,
    _SignedOut event,
  ) async {
    await _authRepository.signOut();
    emit(const AuthState.unauthenticated());
  }

  FutureOr<void> _mapAuthCheckRequestToState(
    Emitter<AuthState> emit,
    _AuthCheckRequested event,
  ) async {
    final userOption = await _authRepository.getSignedInUser();

    emit(
      userOption.fold(
        () => const AuthState.unauthenticated(),
        (user) => AuthState.authenticated(user),
      ),
    );
  }

  /// Reset auth state
  FutureOr<void> _mapResetToState(
    Emitter<AuthState> emit,
    event,
  ) async {
    _verifyStreamSubscription?.cancel();
    _credential = null;
    emit(const _Initial());
  }

  /// Handle auth updating state [_Updated]
  FutureOr<void> _mapUpdatedToState(
    Emitter<AuthState> emit,
    _Updated event,
  ) async {
    emit(
      event.failureOrCredential.fold(
        (failure) => AuthState.authError(failure),
        (r) {
          _credential = r.credential;

          if (r is _SmsCodeSent) {
            return const AuthState.smsCodeSent();
          } else if (r is _CodeRetrievalTimedOut) {
            return const AuthState.codeRetrievalTimedOut();
          } else if (r is _VerificationCompleted) {
            return AuthState.verificationCompleted(
              _credential?.smsCode ?? '',
            );
          }

          throw Exception();
        },
      ),
    );
  }

  /// Submit phone for validation [_SignInWithPhone]
  FutureOr<void> _mapSignInWithPhoneToState(
    Emitter<AuthState> emit,
    _SignInWithPhone event,
  ) async {
    emit(const AuthState.signingInUser());

    if (_credential == null) {
      emit(const AuthState.authError(AuthFailure.verificationFailed()));
    } else {
      final authSuccessOrFailure = await _authRepository.signInWithPhone(
        authCredentials: _credential!.copyWith(smsCode: event.smsCode),
      );

      authSuccessOrFailure.fold(
        (failure) => emit(AuthState.authError(failure)),
        (success) => emit(AuthState.loggedIn(isNewUser: success)),
      );
    }
  }

  /// Submit SMS code for validation completion [_VerifyPhone]
  FutureOr<void> _mapVerifyPhoneToState(
    Emitter<AuthState> emit,
    _VerifyPhone event,
  ) async {
    emit(const AuthState.awaitingVerification());
    _phone = event.phoneNumber;

    _verifyStreamSubscription =
        _authRepository.verifyPhone(phoneNumber: event.phoneNumber).listen(
              (failureOrCredential) =>
                  add(AuthEvent.updated(failureOrCredential)),
            );
  }

  @override
  Future<void> close() async {
    _verifyStreamSubscription?.cancel();
    _authenticationStateSubscription?.cancel();
    super.close();
  }
}
