import 'package:collaction_app/presentation/shared_widgets/selectable_chip.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('SelectableChip tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: SelectableChip(text: 'text'));
      await tester.pumpAndSettle();

      expect(find.byType(SelectableChip), findsOneWidget);
      expect(find.text('text'), findsOneWidget);
      expect(
        tester
            .firstWidget<SelectableChip>(find.byType(SelectableChip))
            .selected,
        false,
      );
    });

    testWidgets('can render selected', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: SelectableChip(
          text: 'text',
          selected: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(
        tester
            .firstWidget<SelectableChip>(find.byType(SelectableChip))
            .selected,
        true,
      );
    });

    testWidgets('onTap called correctly', (WidgetTester tester) async {
      bool onTapCalled = false;
      await buildAndPump(
        tester: tester,
        widget: SelectableChip(
          text: 'text',
          onTap: () => onTapCalled = true,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byType(SelectableChip));

      expect(onTapCalled, true);
    });
  });
}
