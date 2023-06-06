part of 'verified_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpVerifiedPage(GoRouter goRouter) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: VerifiedPage(),
        ),
      ).withRouterScope(goRouter),
    );
  }
}
