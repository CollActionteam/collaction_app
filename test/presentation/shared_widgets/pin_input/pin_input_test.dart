import 'package:collaction_app/presentation/shared_widgets/pin_input/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

part 'pin_input_test.ext.dart';

void main() {
  late MockClipboard clipboard;

  setUpAll(() {
    clipboard = MockClipboard();
  });

  testWidgets(
      'should submit PIN '
      'when long pressed and clipboard has PIN', (WidgetTester tester) async {
    // arrange
    const pinCode = '000000';

    // Put pin in clipboard
    clipboard.setClipboardData(pinCode);

    String? submittedCode;
    await tester.pumpPinInputWidget((pin) {
      submittedCode = pin;
    });

    // Long press first field to paste
    await tester.longPress(find.byKey(const ValueKey('pin_input_0')));

    // assert
    expect(submittedCode, pinCode);
  });

  testWidgets(
      'should do nothing '
      'when long pressed and clipboard has invalid PIN',
      (WidgetTester tester) async {
    // arrange
    const invalidPin = 'some weird text';

    // Set invalid clipboard data
    clipboard.setClipboardData(invalidPin);

    bool isSubmitted = false;
    await tester.pumpPinInputWidget((_) {
      isSubmitted = true;
    });

    // Long press first field to paste
    await tester.longPress(find.byKey(const ValueKey('pin_input_0')));

    // assert
    expect(isSubmitted, false);
  });
}
