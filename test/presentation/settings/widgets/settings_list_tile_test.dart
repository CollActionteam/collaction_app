import 'package:collaction_app/presentation/settings/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helper.dart';

void main() {
  group('SettingsListTile tests', () {
    testWidgets('onTap', (WidgetTester tester) async {
      int counter = 0;

      await buildAndPump(
        tester: tester,
        widget: SettingsListTile(
          title: 'title',
          icon: Icons.abc,
          onTap: () => counter++,
        ),
      );

      await tester.pumpAndSettle();

      expect(counter, 0);
      await tester.tap(find.byType(SettingsListTile));
      expect(counter, 1);
    });
  });
}
