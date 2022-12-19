part of 'verified_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpVerifiedPage(StackRouter stackRouter) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VerifiedPage(),
        ),
      ).withRouterScope(stackRouter),
    );
  }
}
