import 'package:collaction_app/presentation/contact_form/widgets/contact_form.dart';
import 'package:collaction_app/application/contact_form/contact_form_bloc.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:collaction_app/infrastructure/contact_form/contact_form_dto.dart';

import 'package:flutter/material.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test_helper.dart';

class ContactFormBlocMock extends MockBloc<ContactFormEvent, ContactFormState>
    implements ContactFormBloc {}

void main() {
  late final ContactFormBlocMock contactFormBlocMock;

  setUpAll(() {
    contactFormBlocMock = ContactFormBlocMock();
    when(() => contactFormBlocMock.state)
        .thenAnswer((_) => ContactFormState.initial());

    GetIt.I.registerSingleton<ContactFormBloc>(contactFormBlocMock);
  });

  tearDownAll(() {
    GetIt.I.unregister<ContactFormBloc>();
  });
  group('ContactForm tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pumpAndSettle();

      expect(find.byType(ContactForm), findsOneWidget);
      expect(find.text("Get in touch"), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.widgetWithText(PillButton, 'Send'), findsOneWidget);
    });

    testWidgets('validation -- success', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pumpAndSettle();

      // fill out email and message field
      Finder fields = find.byType(TextFormField);

      Widget emailFieldWidget = fields.evaluate().elementAt(0).widget;
      Finder emailField = find.byWidget(emailFieldWidget);
      await tester.enterText(emailField, 'test@test.com');

      Widget messageFieldWidget = fields.evaluate().elementAt(1).widget;
      Finder messageField = find.byWidget(messageFieldWidget);
      await tester.enterText(messageField, 'hello');

      // submit form
      Finder submitBtn = find.widgetWithText(PillButton, 'Send');
      await tester.tap(submitBtn);

      // verify
      verify(() => contactFormBlocMock.add(ContactFormEvent.submitted(
          ContactFormDto(email: 'test@test.com', message: 'hello')))).called(1);
    });
    testWidgets('validation -- fail', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pumpAndSettle();

      expect(find.text("Please enter your email address"), findsNothing);
      expect(find.text("Please enter your feedback"), findsNothing);

      // submit form
      Finder submitBtn = find.widgetWithText(PillButton, 'Send');
      await tester.tap(submitBtn);
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text("Please enter your email address"), findsOneWidget);
      expect(find.text("Please enter your feedback"), findsOneWidget);
    });

    testWidgets('submission -- success snackbar', (WidgetTester tester) async {
      String snackbarText = 'Success! Thank you for contacting us \ud83d\ude42';
      whenListen(
          contactFormBlocMock,
          Stream.fromIterable([
            ContactFormState.initial(),
            ContactFormState.submissionSuccessful()
          ]));

      await buildAndPump(tester: tester, widget: ContactForm());
      expect(find.text(snackbarText), findsNothing);

      await tester.pump();
      expect(find.text(snackbarText), findsOneWidget);
    });

    testWidgets('submission -- fail snackbar', (WidgetTester tester) async {
      String snackbarText = 'Error! Failed to submit form.';
      whenListen(
          contactFormBlocMock,
          Stream.fromIterable(
              [ContactFormState.initial(), ContactFormState.failed('fail')]));

      await buildAndPump(tester: tester, widget: ContactForm());
      expect(find.text(snackbarText), findsNothing);

      await tester.pump();
      expect(find.text(snackbarText), findsOneWidget);
    });
  });
}
