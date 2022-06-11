import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user_profile/profile_description/profile_description_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tProfileDescriptionBloc = ProfileDescriptionBloc();

  group('Testing Profile Description BLoC', () {
    test('Testing inital state', () {
      expect(
        tProfileDescriptionBloc.state,
        const ProfileDescriptionState.initial(),
      );
    });

    blocTest(
      'Testing Edit Profile Pressed event',
      build: () => ProfileDescriptionBloc(),
      act: (ProfileDescriptionBloc bloc) => bloc.add(
        const ProfileDescriptionEvent.editProfilePressed(),
      ),
      expect: () => [
        const ProfileDescriptionState.modifyingDescription(),
      ],
    );
    blocTest(
      'Testing Save Changes Pressed event',
      build: () => ProfileDescriptionBloc(),
      act: (ProfileDescriptionBloc bloc) => bloc.add(
        const ProfileDescriptionEvent.saveChangesPressed(),
      ),
      expect: () => [
        const ProfileDescriptionState.updatingDescription(),
      ],
    );
    blocTest(
      'Testing Cancel Pressed event',
      build: () => ProfileDescriptionBloc(),
      act: (ProfileDescriptionBloc bloc) => bloc.add(
        const ProfileDescriptionEvent.cancelPressed(),
      ),
      expect: () => [
        const ProfileDescriptionState.updatingDescription(),
      ],
    );
  });
}
