import 'package:collaction_app/presentation/core/collaction_icons.dart';
import 'package:collaction_app/presentation/onboarding/widgets/onboarding_step.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('OnboardingStep tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: OnboardingStep(
            icon: CollactionIcons.collaction,
            title: 'title',
            message: 'message',
          ));
      await tester.pumpAndSettle();

      expect(find.byType(OnboardingStep), findsOneWidget);
    });
  });
}
