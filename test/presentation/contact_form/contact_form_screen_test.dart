import 'package:collaction_app/presentation/contact_form/contact_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test_helper.dart';

void main() {
  group('ContactForm tests', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: ContactFormPage());
      await tester.pumpAndSettle();

      expect(find.byType(ContactFormPage), findsOneWidget);
    });
  });
}
