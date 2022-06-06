import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/auth/auth_success.dart';
import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';

import 'auth_bloc_fixtures.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  group('Authentication BLoC', () {
    test('Initial auth state', () {
      final bloc = AuthBloc(MockAuthRepository());
      expect(bloc.state, const AuthState.initial());
    });

    const verificationId = 'verificationId';
    const smsCode = '123456';

    registerFallbackValue(
      const Credential(verificationId: verificationId, smsCode: smsCode),
    );

    final authRepository = MockAuthRepository();

    {
      when(
        () => authRepository.verifyPhone(
          phoneNumber: any(named: 'phoneNumber'),
        ),
      ).thenAnswer(
        (_) => Stream.fromIterable([
          right(
            const AuthSuccess.codeSent(
              credential: Credential(
                verificationId: verificationId,
              ),
            ),
          ),
        ]),
      );

      when(
        () => authRepository.signInWithPhone(
          authCredentials: any(named: 'authCredentials'),
        ),
      ).thenAnswer((_) => Future.value(right(true)));

      when(() => authRepository.signOut())
          .thenAnswer((_) => Future<void>.value());

      blocTest(
        '"Happy path" transition coverage',
        build: () => AuthBloc(authRepository),
        act: (AuthBloc bloc) {
          bloc.add(const AuthEvent.verifyPhone('+1234567890'));
        },
        expect: () => [
          const AuthState.awaitingVerification(),
          const AuthState.smsCodeSent(),
        ],
      );

      blocTest(
        'SMS Submission',
        build: () => AuthBloc(authRepository),
        act: (AuthBloc bloc) async {
          bloc.add(const AuthEvent.verifyPhone('+1234567890'));
          await Future.delayed(const Duration(seconds: 2));
          bloc.add(const AuthEvent.signInWithPhone(smsCode));
        },
        expect: () => [
          const AuthState.awaitingVerification(),
          const AuthState.smsCodeSent(),
          const AuthState.signingInUser(),
          const AuthState.loggedIn(isNewUser: true),
        ],
      );

      blocTest(
        'Sign Out',
        build: () => AuthBloc(authRepository),
        act: (AuthBloc bloc) async {
          bloc.add(const AuthEvent.signedOut());
        },
        expect: () => [
          const AuthState.unAuthenticated(),
        ],
      );
    }

    {
      final authRepository = MockAuthRepository();
      const error = AuthFailure.verificationFailed();
      when(
        () => authRepository.verifyPhone(
          phoneNumber: any(named: 'phoneNumber'),
        ),
      ).thenAnswer((_) => Stream.fromIterable([left(error)]));

      blocTest(
        'Error auth states',
        build: () => AuthBloc(authRepository),
        act: (AuthBloc bloc) {
          bloc.add(const AuthEvent.verifyPhone('+1234567890'));
        },
        expect: () => [
          const AuthState.awaitingVerification(),
          const AuthState.authError(error)
        ],
      );
    }

    {
      when(() => authRepository.updateUsername(username: 'tUsernameFailure'))
          .thenAnswer(
              (_) => Future.value(left(const AuthFailure.serverError())));

      when(() => authRepository.updateUsername(username: 'tUsernameSuccess'))
          .thenAnswer((_) => Future.value(right(unit)));

      blocTest(
        'Update username failed',
        build: () => AuthBloc(authRepository),
        act: (AuthBloc bloc) async {
          bloc.add(const AuthEvent.updateUsername('tUsernameFailure'));
        },
        expect: () => [
          const AuthState.awaitingUsernameUpdate(),
          const AuthState.authError(AuthFailure.serverError())
        ],
      );
      blocTest(
        'Update username success',
        build: () => AuthBloc(authRepository),
        act: (AuthBloc bloc) async {
          bloc.add(const AuthEvent.updateUsername('tUsernameSuccess'));
        },
        expect: () => [
          const AuthState.awaitingUsernameUpdate(),
          const AuthState.usernameUpdateDone(),
        ],
      );
    }

    {
      when(() => authRepository.getSignedInUser())
          .thenAnswer((_) => Future.value(none()));
      blocTest(
        'AuthCheck requested unauthenticated',
        build: () => AuthBloc(authRepository),
        act: (AuthBloc bloc) {
          bloc.add(const AuthEvent.authCheckRequested());
        },
        expect: () => [const AuthState.unAuthenticated()],
      );
    }

    {
      final tAuthRepo2 = MockAuthRepository();
      when(() => tAuthRepo2.getSignedInUser())
          .thenAnswer((_) => Future.value(some(tUser)));
      blocTest(
        'AuthCheck requested authenticated',
        build: () => AuthBloc(tAuthRepo2),
        act: (AuthBloc bloc) {
          bloc.add(const AuthEvent.authCheckRequested());
        },
        expect: () => [const AuthState.authenticated(tUser)],
      );
    }

    blocTest(
      'Reset to initial auth state',
      build: () => AuthBloc(MockAuthRepository()),
      act: (AuthBloc bloc) {
        bloc.add(const AuthEvent.reset());
      },
      expect: () => [const AuthState.initial()],
    );
  });
}
