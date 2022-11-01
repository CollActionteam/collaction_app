import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/domain/user/i_avatar_repository.dart';
import 'package:collaction_app/domain/user/i_profile_repository.dart';
import 'package:collaction_app/domain/user/profile_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../domain/user/user_fixture.dart';
import '../../../test_utilities.dart';

void main() {
  late IProfileRepository profileRepository;
  late IAvatarRepository avatarRepository;
  late ProfileBloc profileBloc;

  const userProfile = cUserProfile;

  setUp(() {
    profileRepository = MockProfileRepository();
    avatarRepository = MockAvatarRepository();
    profileBloc = ProfileBloc(profileRepository, avatarRepository);
  });

  test('should have [ProfileState.initial()] as initial state', () async {
    /// assert
    expect(profileBloc.state, equals(ProfileState.initial()));
  });

  blocTest<ProfileBloc, ProfileState>(
    'should return [ProfileState] with user profile '
    'when profile retrieval is successful',
    setUp: () {
      when(() => profileRepository.getUserProfile())
          .thenAnswer((_) async => const Right(userProfile));
    },
    build: () => profileBloc,
    act: (bloc) => [bloc.add(GetUserProfile())],
    expect: () => const [
      ProfileState(
        userProfile: userProfile,
        isPicEditing: false,
        wasProfilePictureUpdated: false,
        isBioEditing: false,
      )
    ],
    verify: (_) => verify(() => profileRepository.getUserProfile()).called(1),
  );

  blocTest<ProfileBloc, ProfileState>(
    'should return [ProfileState] with null user profile '
    'when profile retrieval is not successful',
    setUp: () {
      when(() => profileRepository.getUserProfile())
          .thenAnswer((_) async => const Left(ProfileFailure.unexpected()));
    },
    build: () => profileBloc,
    act: (bloc) => [bloc.add(GetUserProfile())],
    expect: () => const [
      ProfileState(
        userProfile: null,
        isPicEditing: false,
        isBioEditing: false,
      )
    ],
    verify: (_) => verify(() => profileRepository.getUserProfile()).called(1),
  );

  /// TODO(obella): Add more tests
}
