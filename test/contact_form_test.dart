// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:collaction_app/main.dart';

void main() {
   testWidgets('Contact form widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Tap the button and trigger a page transition
    await tester.tap(find.text('Give feedback or start crowd action'));
    await tester.pumpAndSettle();

    // Verify that the page has changed.
   final finder = find.text("Contact form");
   expect(finder, findsOneWidget);

  });
}
