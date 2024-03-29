import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user/avatar/avatar_bloc.dart';
import 'package:collaction_app/domain/user/upload_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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

    final avatarRepo2 = MockAvatarRepo();
    when(() => avatarRepo2.uploadAvatar(tAvatarFile)).thenAnswer(
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

    final avatarRepo3 = MockAvatarRepo();
    when(() => avatarRepo3.uploadAvatar(tAvatarFile)).thenAnswer(
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
  });
}
