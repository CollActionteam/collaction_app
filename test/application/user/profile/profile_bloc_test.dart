import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/domain/user/profile_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'profile_fixtures.dart';

void main() {
  group('Testing Profile BLoC initial state', () {
    test('Testing initial state', () {
      expect(tProfileBloc.state, ProfileState.initial());
    });

    {
      when(() => tProfileRepository.getUserProfile()).thenAnswer(
        (_) => Future.value(left(const ProfileFailure.unexpected())),
      );
      blocTest(
        'Testing GetUserProfile Event Failure',
        build: () => ProfileBloc(tProfileRepository, tAvatarRepository),
        act: (ProfileBloc bloc) => bloc.add(GetUserProfile()),
        expect: () => [
          const ProfileState(userProfile: null, isEditing: false),
        ],
      );
    }
    {
      final tProfileRepository1 = tProfileRepository;
      when(() => tProfileRepository1.getUserProfile()).thenAnswer(
        (_) => Future.value(right(tUserProfile)),
      );

      test('Tesdint ', () {
        final x = ProfileBloc(tProfileRepository1, tAvatarRepository);
        x.add(GetUserProfile());
        expect(x.state.userProfile, tUserProfile);
        expect(x.state.isEditing, false);
      });
      // blocTest(
      //   'Testing GetUserProfile Event Success',
      //   build: () => ProfileBloc(tProfileRepository1, tAvatarRepository),
      //   act: (ProfileBloc bloc) => bloc.add(GetUserProfile()),
      //   expect: () => [],
      // );
    }
  });
}
