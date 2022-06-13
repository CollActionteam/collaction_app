import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user/avatar/avatar_bloc.dart';
import 'package:collaction_app/domain/user/upload_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_utilities.dart';
import 'avatar_bloc_fixtures.dart';

void main() {
  group('Testing Avatar BLoC', () {
    test('Testing initial state', () {
      expect(tAvatarBloc.state, const AvatarState.initial());
    });

    test('Testing started event', () {
      tAvatarBloc.add(const AvatarEvent.started());
      expect(tAvatarBloc.state, const AvatarState.initial());
    });

    {
      final avatarRepo1 = MockAvatarRepository();
      when(() => avatarRepo1.getAvatarUploadPath()).thenAnswer(
        (_) => Future.value(
          left(const UploadPathFailure.unexpected()),
        ),
      );
      blocTest(
        'Testing upload URI failure',
        build: () => AvatarBloc(avatarRepo1),
        act: (AvatarBloc bloc) => bloc.add(
          AvatarEvent.uploadAvatar(tAvatarFile),
        ),
        expect: () => [
          const AvatarState.uploading(),
          const AvatarState.uploadFailed(),
        ],
      );
    }

    {
      final avatarRepo2 = MockAvatarRepository();

      when(() => avatarRepo2.getAvatarUploadPath()).thenAnswer(
        (_) => Future.value(right(tUri)),
      );

      when(() => avatarRepo2.uploadAvatar(tAvatarFile, tUri)).thenAnswer(
        (_) => Future.value(left(const UploadFailure.uploadFailed())),
      );

      blocTest(
        'Testing upload URI success but upload avatar failed',
        build: () => AvatarBloc(avatarRepo2),
        act: (AvatarBloc bloc) {
          bloc.add(AvatarEvent.uploadAvatar(tAvatarFile));
        },
        expect: () => [
          const AvatarState.uploading(),
          const AvatarState.uploadFailed(),
        ],
      );
    }
    {
      final avatarRepo3 = MockAvatarRepository();
      when(() => avatarRepo3.getAvatarUploadPath()).thenAnswer(
        (_) => Future.value(right(tUri)),
      );

      when(() => avatarRepo3.uploadAvatar(tAvatarFile, tUri)).thenAnswer(
        (_) => Future.value(right(unit)),
      );

      blocTest(
        'Testing upload URI success and upload avatar success',
        build: () => AvatarBloc(avatarRepo3),
        act: (AvatarBloc bloc) {
          bloc.add(AvatarEvent.uploadAvatar(tAvatarFile));
        },
        expect: () => [
          const AvatarState.uploading(),
          const AvatarState.uploadSuccess(),
        ],
      );
    }
  });
}
