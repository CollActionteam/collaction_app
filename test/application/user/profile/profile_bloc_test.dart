import 'package:collaction_app/application/user/profile/profile_bloc.dart';
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
      final tProfileRepository1 = tProfileRepository;
      when(() => tProfileRepository1.getUserProfile()).thenAnswer(
        (_) => Future.value(right(tUserProfile)),
      );
    }
  });
}
