import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/domain/user/i_user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  group('Authentication BLoC', () {
    test('Initial auth state', () {
      final bloc = AuthBloc(MockUserRepository());
      expect(bloc.state, const AuthState.initial());
    });

    const verificationId = 'verificationId';
    const smsCode = '123456';
    registerFallbackValue(const Credential(verificationId:verificationId, smsCode:smsCode));

    {
      final userRepository = MockUserRepository();
      when(() => userRepository.registerPhoneNumber(any()))
          .thenAnswer((_) => Stream.fromIterable([
                const Credential(verificationId:verificationId),
                const Credential(verificationId:verificationId, smsCode:smsCode),
              ]));
      when(() => userRepository.signIn(any()))
          .thenAnswer((_) => Future.value(SignInResult(isNewUser: true)));
      blocTest('"Happy path" transition coverage',
          build: () => AuthBloc(userRepository),
          act: (AuthBloc bloc) {
            bloc.add(const AuthEvent.registerPhoneNumber('+1234567890'));
          },
          expect: () => [
                const AuthState.registeringPhoneNumber(),
                const AuthState.awaitingVerification(),
                const AuthState.verifying(smsCode),
                const AuthState.loggedIn(isNewUser: true)
              ]);
    }

    {
      final userRepository = MockUserRepository();
      final error = Exception('Test error');
      when(() => userRepository.registerPhoneNumber(any()))
          .thenAnswer((_) => Stream.error(error));
      blocTest('Error auth states',
          build: () => AuthBloc(userRepository),
          act: (AuthBloc bloc) {
            bloc.add(const AuthEvent.registerPhoneNumber('+1234567890'));
          },
          expect: () => [
                const AuthState.registeringPhoneNumber(),
                AuthState.authError(error)
              ]);
    }

    blocTest('Reset to initial auth state',
        build: () => AuthBloc(MockUserRepository()),
        seed: () => const AuthState.awaitingVerification(),
        act: (AuthBloc bloc) {
          bloc.add(const AuthEvent.reset());
        },
        expect: () => [const AuthState.initial()]);
  });
}
