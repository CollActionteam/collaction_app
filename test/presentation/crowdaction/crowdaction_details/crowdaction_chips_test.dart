import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/crowdaction_chips.dart';
import 'package:collaction_app/presentation/shared_widgets/accent_chip.dart';
import 'package:collaction_app/presentation/shared_widgets/secondary_chip.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer/shimmer.dart';

import '../../../test_helper.dart';

void main() {
  group('CrowdAction Chips', () {
    testWidgets('No Category State', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: MaterialApp(
            theme: lightTheme(), home: CrowdActionChips(category: null)),
      );
      await tester.pump();

      expect(find.byType(AccentChip), findsNothing);
      expect(find.byType(SecondaryChip), findsNWidgets(2));

      expect(find.byType(Shimmer), findsNWidgets(2));
    });

    testWidgets('Category State', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: MaterialApp(
          theme: lightTheme(),
          home: CrowdActionChips(
            category: 'Category-Test',
            subCategory: 'Subcategory-Test',
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(AccentChip), findsOneWidget);
      expect(find.byType(SecondaryChip), findsNWidgets(2));

      expect(find.byType(Shimmer), findsNothing);
    });
  });
}
