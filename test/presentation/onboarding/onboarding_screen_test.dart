import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:collaction_app/presentation/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_helper.dart';

class SettingsRepositoryMock extends Mock implements ISettingsRepository {}

void main() {
  late final ISettingsRepository settingsRepositoryMock;

  setUpAll(() {
    settingsRepositoryMock = SettingsRepositoryMock();
    getIt.registerFactory<ISettingsRepository>(() => settingsRepositoryMock);

    when(() => settingsRepositoryMock.setWasUserOnboarded(wasOnboarded: true))
        .thenAnswer((invocation) => Future.value());
  });

  group('OnboardingStep tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: OnboardingPage());
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingPage), findsOneWidget);
    });

    testWidgets('can continue', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: OnboardingPage());
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingPage), findsOneWidget);

      final state =
          tester.state<OnboardingPageState>(find.byType(OnboardingPage));

      expect(state.currentPage, 0);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(state.currentPage, 1);
    });

    testWidgets('can skip', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: Builder(
          builder: (context) {
            return TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OnboardingPage()),
                );
              },
              child: Text('Push onboarding'),
            );
          },
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Push onboarding'), findsOneWidget);

      await tester.tap(find.text('Push onboarding'));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingPage), findsOneWidget);

      /// TODO: Finish tests when proof of concept of testing auto_route is done
      // await tester.tap(find.byType(TextButton));
      // await tester.pumpAndSettle();

      // expect(find.byType(OnboardingPage), findsNothing);
      // expect(find.text('Push onboarding'), findsOneWidget);
    });
  });
}
