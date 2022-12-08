import 'package:collaction_app/presentation/shared_widgets/phone_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../test_helper.dart';

void main() {
  const channel = MethodChannel('com.julienvignali/phone_number');

  setUp(() async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.arguments['string'] == '31 0612345678') {
        return {'isValid': true};
      }
      return null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('PhoneInput tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await buildAndPump(
          tester: tester, widget: PhoneInput(TextEditingController()));
      await tester.pumpAndSettle();

      expect(find.byType(PhoneInput), findsOneWidget);
      expect(find.text('Enter a valid phone number'), findsOneWidget);
      expect(find.text('+31'), findsOneWidget);
    });

    testWidgets('correct message when number is invalid',
        (WidgetTester tester) async {
      await buildAndPump(
          tester: tester, widget: PhoneInput(TextEditingController()));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), '12345');
      await tester.pumpAndSettle();
      expect(find.text('Your phone number is not valid'), findsOneWidget);
    });

    testWidgets('correct message when number is valid',
        (WidgetTester tester) async {
      await buildAndPump(
          tester: tester,
          widget: PhoneInput(
            TextEditingController(),
          ));
      await tester.enterText(find.byType(TextFormField), '0612345678');
      await tester.pumpAndSettle();
      expect(find.text('+31'), findsOneWidget);
      expect(find.text('0612345678'), findsOneWidget);
      expect(find.text('We will send you a code to activate your account'),
          findsOneWidget);
    });

    testWidgets('callbacks called when text changed',
        (WidgetTester tester) async {
      bool _isValid = false;
      bool _onChange = false;
      await buildAndPump(
          tester: tester,
          widget: PhoneInput(
            TextEditingController(),
            isValid: (_) {
              _isValid = true;
            },
            onChange: (_) {
              _onChange = true;
            },
          ));
      await tester.enterText(find.byType(TextFormField), '0612345678');
      await tester.pumpAndSettle();
      expect(_isValid, true);
      expect(_onChange, true);
    });
  });
}
