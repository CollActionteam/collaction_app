part of 'verified_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpVerifiedPage(StackRouter stackRouter) async {
    await pumpWidget(
      MaterialApp(
        theme: lightTheme(),
        home: Scaffold(
          body: VerifiedPage(),
        ),
      ).withRouterScope(stackRouter),
    );
  }
}
