import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/username/username_bloc.dart';
import 'package:collaction_app/domain/user/profile_failure.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_utilities.dart';

void main() {
  group('Testing Username BLoC', () {
    late final MockProfileRepository profileRepository;
    late UsernameBloc bloc;

    setUpAll(() {
      profileRepository = MockProfileRepository();
      bloc = UsernameBloc(profileRepository);
    });

    setUp(() {
      // Reset BLOC
      bloc = UsernameBloc(profileRepository);
    });

    test('Initial state', () {
      expect(bloc.state, const UsernameState.initial());
    });

    blocTest(
      'Update username success',
      build: () => bloc,
      act: (bloc) {
        when(() => profileRepository.updateUsername(
            firstName: tFirstName, lastName: tLastName)).thenAnswer(
          (_) => Future.value(right(unit)),
        );

        bloc.add(UsernameEvent.updateUsername(
            firstName: tFirstName, lastName: tLastName));
      },
      expect: () => [
        const UsernameState.updateInProgress(),
        UsernameState.updateSuccess('$tFirstName $tLastName'),
      ],
    );

    blocTest(
      'Update username failure',
      build: () => bloc,
      act: (bloc) {
        when(() => profileRepository.updateUsername(
            firstName: tFirstName, lastName: tLastName)).thenAnswer(
          (_) => Future.value(left(ProfileFailure.unexpected())),
        );

        bloc.add(UsernameEvent.updateUsername(
            firstName: tFirstName, lastName: tLastName));
      },
      expect: () => [
        const UsernameState.updateInProgress(),
        const UsernameState.updateFailure(),
      ],
    );
  });
}

final tFirstName = "Mathias";
final tLastName = "M";
