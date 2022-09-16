import 'package:collaction_app/presentation/core/app_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {});

  testWidgets('Can render AppWidget', (WidgetTester tester) async {
    await tester.pumpWidget(AppWidget());

    expect(find.byType(AppWidget), findsOneWidget);
  });
}
