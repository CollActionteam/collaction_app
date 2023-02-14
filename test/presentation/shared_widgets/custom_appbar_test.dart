import 'package:collaction_app/presentation/shared_widgets/custom_app_bars/custom_appbar.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('CustomAppBar tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CustomAppBar());
      await tester.pump();

      expect(find.byType(CustomAppBar), findsOneWidget);
    });

    testWidgets('closable', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: CustomAppBar(closable: true));
      await tester.pump();

      expect(find.byType(CustomAppBar), findsOneWidget);
    });

    testWidgets('preferredSize', (WidgetTester tester) async {
      final appbar = CustomAppBar();
      await tester.pumpWidget(
          MaterialApp(theme: lightTheme(), home: Scaffold(appBar: appbar)));
      await tester.pump();

      expect(find.byType(CustomAppBar), findsOneWidget);

      final size = tester.getSize(find.byType(CustomAppBar));

      expect(size.height, appbar.preferredSize.height);
    });
  });
}
