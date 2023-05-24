import 'package:collaction_app/presentation/settings/settings_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../router.mocks.dart';

part 'settings_layout_test.ext.dart';

void main() {
  late GoRouter goRouter;

  setUpAll(() {
    goRouter = RouteHelpers.setUpRouterStubs();
  });

  group('SettingsLayout tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpSettingsLayout(goRouter);
      await tester.pumpAndSettle();

      expect(find.byType(SettingsLayout), findsOneWidget);
    });

    testWidgets('back ElevatedButton works', (WidgetTester tester) async {
      await tester.pumpSettingsLayout(goRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ElevatedButton));
      final capturedPops = verify(() => goRouter.pop()).callCount;

      expect(capturedPops, 1);
    });

    testWidgets('back RawMaterialButton works', (WidgetTester tester) async {
      await tester.pumpSettingsLayout(goRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(RawMaterialButton));
      final capturedPops = verify(() => goRouter.pop());
      expect(capturedPops.callCount, 1);
    });
  });
}
