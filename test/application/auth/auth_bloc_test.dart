import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/auth/auth_success.dart';
import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/user/i_avatar_repository.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class MockAvatarRepository extends Mock implements IAvatarRepository {}

void main() {
  group('Authentication BLoC', () {
    test('Initial auth state', () {
      final userRepository = MockAuthRepository();

      when(() => userRepository.observeUser())
          .thenAnswer((_) => Stream.empty());

      final bloc = AuthBloc(userRepository, MockAvatarRepository());
      expect(bloc.state, const AuthState.initial());
    });

    const verificationId = 'verificationId';
    const smsCode = '123456';

    registerFallbackValue(
      const Credential(verificationId: verificationId, smsCode: smsCode),
    );

    final userRepository = MockAuthRepository();
    final avatarRepository = MockAvatarRepository();

    {
      when(() => userRepository.observeUser())
          .thenAnswer((_) => Stream.empty());

      when(
        () => userRepository.verifyPhone(
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
        () => userRepository.signInWithPhone(
          authCredentials: any(named: 'authCredentials'),
        ),
      ).thenAnswer((_) => Future.value(right(true)));

      blocTest(
        '"Happy path" transition coverage',
        build: () => AuthBloc(userRepository, avatarRepository),
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
        build: () => AuthBloc(userRepository, avatarRepository),
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
    }

    {
      final userRepository = MockAuthRepository();

      when(() => userRepository.observeUser())
          .thenAnswer((_) => Stream.empty());

      const error = AuthFailure.verificationFailed();
      when(
        () => userRepository.verifyPhone(
          phoneNumber: any(named: 'phoneNumber'),
        ),
      ).thenAnswer((_) => Stream.fromIterable([left(error)]));

      blocTest(
        'Error auth states',
        build: () => AuthBloc(userRepository, avatarRepository),
        act: (AuthBloc bloc) {
          bloc.add(const AuthEvent.verifyPhone('+1234567890'));
        },
        expect: () => [
          const AuthState.awaitingVerification(),
          const AuthState.authError(error)
        ],
      );
    }

    blocTest(
      'Reset to initial auth state',
      build: () => AuthBloc(userRepository, MockAvatarRepository()),
      act: (AuthBloc bloc) {
        bloc.add(const AuthEvent.reset());
      },
      expect: () => [const AuthState.initial()],
    );
  });
}
