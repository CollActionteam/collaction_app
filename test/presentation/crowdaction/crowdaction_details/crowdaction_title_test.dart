import 'package:collaction_app/presentation/crowdaction/crowdaction_details/widgets/crowdaction_title.dart';
import 'package:collaction_app/presentation/shared_widgets/shimmers/title_shimmer_line.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CrowdactionTitle tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CrowdActionTitle(
            title: 'Test title',
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Test title'), findsOneWidget);
      expect(find.byType(TitleShimmerLine), findsNothing);
    });

    testWidgets('shimmers', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: lightTheme(),
          home: CrowdActionTitle(
            title: null,
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(TitleShimmerLine), findsNWidgets(2));
    });
  });
}
