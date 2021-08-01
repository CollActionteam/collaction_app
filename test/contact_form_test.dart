import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:collaction_app/main.dart';

void main() {
  testWidgets('Contact form renders', (WidgetTester tester) async {
    // Build our app and contact form.
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Give feedback or start crowd action'));
    await tester.pumpAndSettle();

    // Verify that the page is rendered with all its elements.
    expect(find.text("Contact form"), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text("Submit"), findsOneWidget);
  });

  testWidgets('Form can be submitted', (WidgetTester tester) async {
    // Build app and contact form
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Give feedback or start crowd action'));
    await tester.pumpAndSettle();

    final Finder emailAddress =
        find.widgetWithText(TextFormField, 'Your email address');
    final Finder feedback =
        find.widgetWithText(TextFormField, 'Your feedback or request');
    final Finder submit = find.widgetWithText(ElevatedButton, 'Submit');

    expect(find.text('Processing data'), findsNothing);

    await tester.enterText(emailAddress, 'example@mail.com');
    await tester.enterText(feedback, 'blablabla');
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Processing data'), findsOneWidget);
  });

  testWidgets('Form requires email and feedback', (WidgetTester tester) async {
    // Build app and contact form
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Give feedback or start crowd action'));
    await tester.pumpAndSettle();

    final Finder submit = find.widgetWithText(ElevatedButton, 'Submit');

    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Please enter your email address'), findsOneWidget);
    expect(find.text('Please enter your feedback'), findsOneWidget);
  });

  testWidgets('Check for valid email address', (WidgetTester tester) async {
    // Build app and contact form
    await tester.pumpWidget(MyApp());
    await tester.tap(find.text('Give feedback or start crowd action'));
    await tester.pumpAndSettle();

    final Finder emailAddress =
        find.widgetWithText(TextFormField, 'Your email address');
    final Finder submit = find.widgetWithText(ElevatedButton, 'Submit');

    await tester.enterText(emailAddress, 'example@mailcom');
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Please enter a valid email address'), findsOneWidget);
  });
}
