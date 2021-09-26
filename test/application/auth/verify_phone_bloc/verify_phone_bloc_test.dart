import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/auth/verify_phone_bloc/verify_phone_bloc.dart';
import 'package:collaction_app/domain/auth/auth_failures.dart';
import 'package:collaction_app/domain/auth/auth_success.dart';
import 'package:collaction_app/domain/auth/i_auth_repository.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  group('Authentication BLoC', () {
    test('Initial auth state', () {
      final bloc = VerifyPhoneBloc(MockAuthRepository());
      expect(bloc.state, const VerifyPhoneState.initial());
    });

    const verificationId = 'verificationId';
    const smsCode = '123456';

    registerFallbackValue(
        const Credential(verificationId: verificationId, smsCode: smsCode));

    final userRepository = MockAuthRepository();

    {
      when(() => userRepository.verifyPhone(
              phoneNumber: any(named: 'phoneNumber')))
          .thenAnswer((_) => Stream.fromIterable([
                right(const AuthSuccess.codeSent(
                    credential: Credential(
                  verificationId: verificationId,
                ))),
              ]));

      when(() => userRepository.signInWithPhone(
              authCredentials: any(named: 'authCredentials')))
          .thenAnswer((_) => Future.value(right(true)));

      blocTest(
        '"Happy path" transition coverage',
        build: () => VerifyPhoneBloc(userRepository),
        act: (VerifyPhoneBloc bloc) {
          bloc.add(const VerifyPhoneEvent.verifyPhone('+1234567890'));
        },
        expect: () => [
          const VerifyPhoneState.awaitingVerification(),
          const VerifyPhoneState.smsCodeSent(),
        ],
      );

      blocTest(
        'SMS Submission',
        build: () => VerifyPhoneBloc(userRepository),
        act: (VerifyPhoneBloc bloc) async {
          bloc.add(const VerifyPhoneEvent.verifyPhone('+1234567890'));
          await Future.delayed(const Duration(seconds: 2));
          bloc.add(const VerifyPhoneEvent.signInWithPhone(smsCode));
        },
        expect: () => [
          const VerifyPhoneState.awaitingVerification(),
          const VerifyPhoneState.smsCodeSent(),
          const VerifyPhoneState.signingInUser(),
          const VerifyPhoneState.loggedIn(isNewUser: true),
        ],
      );
    }

    {
      final userRepository = MockAuthRepository();
      const error = AuthFailure.verificationFailed();
      when(() => userRepository.verifyPhone(
              phoneNumber: any(named: 'phoneNumber')))
          .thenAnswer((_) => Stream.fromIterable([left(error)]));

      blocTest('Error auth states',
          build: () => VerifyPhoneBloc(userRepository),
          act: (VerifyPhoneBloc bloc) {
            bloc.add(const VerifyPhoneEvent.verifyPhone('+1234567890'));
          },
          expect: () => [
                const VerifyPhoneState.awaitingVerification(),
                const VerifyPhoneState.authError(error)
              ]);
    }

    blocTest('Reset to initial auth state',
        build: () => VerifyPhoneBloc(MockAuthRepository()),
        act: (VerifyPhoneBloc bloc) {
          bloc.add(const VerifyPhoneEvent.reset());
        },
        expect: () => [const VerifyPhoneState.initial()]);
  });
}
