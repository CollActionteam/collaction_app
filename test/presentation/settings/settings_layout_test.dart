import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/settings/settings_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../router.mocks.dart';

void main() {
  late StackRouter stackRouter;

  setUpAll(() {
    stackRouter = RouteHelpers.setUpRouterStubs();
  });

  group('SettingsLayout tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsLayout(),
          ),
        ).withRouterScope(stackRouter),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SettingsLayout), findsOneWidget);
    });

    testWidgets('back ElevatedButton works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsLayout(),
          ),
        ).withRouterScope(stackRouter),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      final capturedPops = verify(() => stackRouter.pop()).callCount;

      expect(capturedPops, 1);
    });

    testWidgets('back RawMaterialButton works', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsLayout(),
          ),
        ).withRouterScope(stackRouter),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RawMaterialButton));
      final capturedPops = verify(() => stackRouter.pop());
      expect(capturedPops.callCount, 1);
    });
  });
}
