import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/settings/build_information/build_information_bloc.dart';
import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsRepository extends Mock implements ISettingsRepository {}

void main() {
  group('Testing Build Information BLoC', () {
    final tSettingsRepo = MockSettingsRepository();
    final tBuildInfoBloc = BuildInformationBloc(tSettingsRepo);
    const tBuildInfo =
        BuildInformation(buildNumber: 'tBuildNum', version: 'tVersion');
    test('Testing initial state', () {
      expect(
        tBuildInfoBloc.state,
        const BuildInformationState.loading(),
      );
    });

    when(() => tSettingsRepo.getBuildInformation())
        .thenAnswer((_) => Future.value(tBuildInfo));

    blocTest('Testing fetch event',
        build: () => tBuildInfoBloc,
        act: (BuildInformationBloc bloc) {
          bloc.add(const BuildInformationEvent.fetch());
        },
        expect: () => [
              const BuildInformationState.loading(),
              const BuildInformationState.fetched(tBuildInfo),
            ]);
  });
}
