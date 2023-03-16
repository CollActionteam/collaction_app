import 'package:collaction_app/application/settings/build_information/build_information_bloc.dart';
import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:collaction_app/presentation/menu/widgets/build_information_tile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/settings/build_information_bloc.mocks.dart';
import '../../test_helper.dart';

void main() {
  group('BuildInformationTile tests', () {
    late final MockBuildInformationBloc bloc;

    setUpAll(() {
      bloc = MockBuildInformationBloc();
      GetIt.I.registerSingleton<BuildInformationBloc>(bloc);
    });

    tearDownAll(() {
      GetIt.I.unregister<BuildInformationBloc>();
    });

    testWidgets('With BuildInformation development',
        (WidgetTester tester) async {
      when(() => bloc.state).thenReturn(
        BuildInformationState.fetched(
          BuildInformation(
            version: '1.0.0',
            buildNumber: '1',
            environment: 'DEVELOPMENT',
          ),
        ),
      );

      await buildAndPump(
        tester: tester,
        widget: BuildInformationTile(),
      );

      await tester.pumpAndSettle();

      expect(find.text('Version 1.0.0'), findsOneWidget);
      expect(find.text('Build 1'), findsOneWidget);
      expect(find.text('Environment DEVELOPMENT'), findsNothing);
    });

    testWidgets('With BuildInformation on production',
        (WidgetTester tester) async {
      when(() => bloc.state).thenReturn(
        BuildInformationState.fetched(
          BuildInformation(
            version: '1.0.0',
            buildNumber: '1',
            environment: 'PRODUCTION',
          ),
        ),
      );

      await buildAndPump(
        tester: tester,
        widget: BuildInformationTile(),
      );

      await tester.pumpAndSettle();

      expect(find.text('Version 1.0.0'), findsOneWidget);
      expect(find.text('Build 1'), findsOneWidget);
      expect(find.text('Environment PRODUCTION'), findsNothing);
    });
  });
}
