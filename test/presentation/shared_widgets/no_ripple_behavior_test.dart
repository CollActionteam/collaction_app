import 'package:collaction_app/presentation/shared_widgets/no_ripple_behavior.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('NoRippleBehavior tests:', () {
    final Key key = Key('noRippleBehavior');
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
        tester: tester,
        widget: ScrollConfiguration(
          behavior: NoRippleBehavior(),
          child: SizedBox(height: 1000),
          key: key,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(key), findsOneWidget);
      expect(
        tester
            .firstWidget<ScrollConfiguration>(find.byKey(key))
            .behavior
            .runtimeType,
        NoRippleBehavior,
      );
    });
  });
}
