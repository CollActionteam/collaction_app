import 'package:collaction_app/application/contact_form/contact_form_bloc.dart';
import 'package:collaction_app/presentation/contact_form/widgets/contact_form.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/contact_form/contact_form_bloc.mocks.dart';
import '../../application/contact_form/contact_form_fixture.dart';
import '../../test_helper.dart';

void main() {
  late ContactFormBloc contactFormBloc;

  setUpAll(() {
    contactFormBloc = MockContactFormBloc();
    when(() => contactFormBloc.state).thenAnswer(
      (_) => ContactFormState.initial(),
    );
    GetIt.I.registerSingleton<ContactFormBloc>(contactFormBloc);
    registerFallbackValue(ContactFormEvent.submitted(tContactFormDtoE));
  });

  tearDownAll(() {
    GetIt.I.unregister<ContactFormBloc>();
  });

  group('ContactForm tests:', () {
    testWidgets('can render when state is initial',
        (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pumpAndSettle();

      expect(find.byType(ContactForm), findsOneWidget);
      expect(find.text('Your email address'), findsOneWidget);
      expect(find.text('Please enter a valid email address'), findsNothing);
      expect(find.text('Please enter your email address'), findsNothing);
      expect(find.text('Your message to us'), findsOneWidget);
      expect(find.text('Please enter your feedback'), findsNothing);
      expect(find.byType(PillButton), findsOneWidget);

      final textFormFields = find.byType(TextFormField);
      expect(
        tester.firstWidget<TextFormField>(textFormFields.first).enabled,
        true,
      );

      expect(
        tester.firstWidget<TextFormField>(textFormFields.last).enabled,
        true,
      );

      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        true,
      );
    });

    testWidgets('email validation correct', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField).first, 'tEmail');
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid email address'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField).first, '');
      await tester.pumpAndSettle();
      expect(find.text('Please enter your email address'), findsOneWidget);

      await tester.enterText(
        find.byType(TextFormField).first,
        'tEmail@collaction.org',
      );
      await tester.pumpAndSettle();
      expect(find.text('Please enter a valid email address'), findsNothing);
      expect(find.text('Please enter your email address'), findsNothing);
    });

    testWidgets('submit button submits only when form is valid',
        (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();

      verifyNever(() => contactFormBloc.add(any()));

      await tester.enterText(
        find.byType(TextFormField).first,
        'tEmail@collaction.org',
      );
      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();

      verifyNever(() => contactFormBloc.add(any()));

      await tester.enterText(
        find.byType(TextFormField).first,
        '',
      );
      await tester.enterText(
        find.byType(TextFormField).last,
        'tMessage',
      );
      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();

      verifyNever(() => contactFormBloc.add(any()));

      await tester.enterText(
        find.byType(TextFormField).first,
        'tEmail@collaction.org',
      );
      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();

      verify(() => contactFormBloc.add(any())).called(1);
    });

    testWidgets('can render when state not initial or failed',
        (WidgetTester tester) async {
      when(() => contactFormBloc.state).thenAnswer(
        (_) => ContactFormState.submitting(),
      );
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pump();

      final textFormFields = find.byType(TextFormField);
      expect(
        tester.firstWidget<TextFormField>(textFormFields.first).enabled,
        false,
      );

      expect(
        tester.firstWidget<TextFormField>(textFormFields.last).enabled,
        false,
      );

      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        false,
      );

      expect(find.text('Send'), findsNothing);
    });

    testWidgets('snackbar renders when state is failed',
        (WidgetTester tester) async {
      when(() => contactFormBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([ContactFormState.failed('failureMessage')]),
      );
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pump();

      expect(find.text('Error! Failed to submit form.'), findsOneWidget);
    });

    testWidgets('snackbar renders when state is submissionSuccessful',
        (WidgetTester tester) async {
      when(() => contactFormBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([ContactFormState.submissionSuccessful()]),
      );
      await buildAndPump(tester: tester, widget: ContactForm());
      await tester.pump();

      expect(find.text('Success! Thank you for contacting us \ud83d\ude42'),
          findsOneWidget);
    });
  });
}
