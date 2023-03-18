import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/settings/build_information/build_information_bloc.dart';

import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../domain/core/i_settings_repository.mocks.dart';

void main() {
  group('Testing Build Information BLoC', () {
    late final SettingsRepositoryMock settingsRepository;
    late final BuildInformationBloc bloc;

    setUpAll(() {
      settingsRepository = SettingsRepositoryMock();
      bloc = BuildInformationBloc(settingsRepository);
    });

    test('Initial state', () {
      expect(bloc.state, const BuildInformationState.loading());
    });

    blocTest(
      'Fetch',
      build: () => bloc,
      act: (bloc) {
        when(() => settingsRepository.getBuildInformation())
            .thenAnswer((_) => Future.value(tBuildInformation));

        bloc.add(BuildInformationEvent.fetch());
      },
      expect: () => [
        const BuildInformationState.loading(),
        BuildInformationState.fetched(tBuildInformation),
      ],
    );
  });
}

final tBuildInformation = BuildInformation(version: '1.0.0', buildNumber: '1');
