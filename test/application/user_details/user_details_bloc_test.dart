import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/user_details/user_details_bloc.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'user_details_fixtures.dart';

void main() {
  group('test User Details BLoC', () {
    final UserDetailsBloc tUserBloc = UserDetailsBloc(tUserRepo);

    test('testing Initial UserDetails BLoC State', () {
      expect(tUserBloc.state, const UserDetailsState.initial());
    });

    when(() => tUserRepo.observeUser()).thenAnswer((_) {
      final x = StreamController<User>();
      x.add(tUser);
      return x.stream.distinct();
    });

    blocTest(
      'testing fetchDetails event',
      build: () => tUserBloc,
      act: (UserDetailsBloc bloc) {
        bloc.add(const UserDetailsEvent.fetchDetails());
      },
      expect: () => [
        const UserDetailsState.fetchingDetails(),
        const UserDetailsState.fetchingDetailsFailed(),
      ],
    );
  });
}
