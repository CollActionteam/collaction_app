import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:collaction_app/presentation/settings/widgets/build_information_tile.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helper.dart';

void main() {
  group('BuildInformationTile tests', () {
    testWidgets('With BuildInformation', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: BuildInformationTile(
          information: BuildInformation(
            version: '1.0.0',
            buildNumber: '1',
            environment: 'test',
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Version 1.0.0'), findsOneWidget);
      expect(find.text('Build 1'), findsOneWidget);
      expect(find.text('Environment TEST'), findsNothing);
    });

    testWidgets('With BuildInformation on development',
        (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: BuildInformationTile(
          information: BuildInformation(
            version: '1.0.0',
            buildNumber: '1',
            environment: 'development',
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Version 1.0.0'), findsOneWidget);
      expect(find.text('Build 1'), findsOneWidget);
      expect(find.text('Environment DEVELOPMENT'), findsOneWidget);
    });
  });
}
