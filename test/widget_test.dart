// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:collaction_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home Page and Transitions', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(AppWidget());

    await tester.pumpAndSettle();

    // Verify that welcome text is shown
    expect(find.text('Upcoming crowdactions'), findsOneWidget);

    // Tap the 'Browse actions' button and trigger a page transition (multiple frame).
    await tester.pumpAndSettle();
    await tester.tap(find.text('View all'));

    // Verify that the page has changed.
    expect(find.text('Browse Crowdactions'), findsNothing);
  });
}
