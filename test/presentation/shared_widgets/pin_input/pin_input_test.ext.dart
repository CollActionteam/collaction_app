part of 'pin_input_test.dart';

extension WidgetTesterX on WidgetTester {
  Future<BuildContext> pumpPinInputWidget(Function(String) onSubmit) async {
    late BuildContext ctx;

    await pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            ctx = context;
            return Material(
              child: Scaffold(body: PinInput(submit: onSubmit)),
            );
          },
        ),
      ),
    );

    return ctx;
  }
}
