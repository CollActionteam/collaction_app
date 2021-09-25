import 'package:collaction_app/presentation/contact_form/contact_form_screen.dart';
import 'package:collaction_app/presentation/shared_widgets/rectangle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utilities.dart';

void main() {
  testWidgets('Contact form renders', (WidgetTester tester) async {
    TestUtilities.mockContactFormApi(doesSubmissionSucceed: true);
    // Build our app and contact form.
    await tester.pumpWidget(const MaterialApp(home: ContactFormPage()));

    // Verify that the page is rendered with all its elements.
    expect(find.text("We want to know what you think!"), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text("Let us know"), findsOneWidget);
  });

  testWidgets('Form can be submitted', (WidgetTester tester) async {
    TestUtilities.mockContactFormApi(doesSubmissionSucceed: true);
    // Build app and contact form
    await tester.pumpWidget(const MaterialApp(home: ContactFormPage()));

    final Finder emailAddress = find.widgetWithText(TextFormField, 'Email');
    final Finder feedback =
        find.widgetWithText(TextFormField, 'Give us your feedback or request');
    final Finder submit = find.widgetWithText(RectangleButton, 'Let us know');

    expect(find.text('Processing data'), findsNothing);

    await tester.enterText(emailAddress, 'example@mail.com');
    await tester.enterText(feedback, 'blablabla');
    await tester.tap(submit);
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Success!'), findsOneWidget);
  });

  testWidgets('Form requires email and feedback', (WidgetTester tester) async {
    // Build app and contact form
    await tester.pumpWidget(const MaterialApp(home: ContactFormPage()));

    final Finder submit = find.widgetWithText(RectangleButton, 'Let us know');

    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Please enter your email address'), findsOneWidget);
    expect(find.text('Please enter your feedback'), findsOneWidget);
  });

  testWidgets('Check for valid email address', (WidgetTester tester) async {
    // Build app and contact form
    await tester.pumpWidget(const MaterialApp(home: ContactFormPage()));

    final Finder emailAddress = find.widgetWithText(TextFormField, 'Email');
    final Finder submit = find.widgetWithText(RectangleButton, 'Let us know');

    await tester.enterText(emailAddress, 'example@gmailcom');
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Please enter a valid email address'), findsOneWidget);
  });
}
