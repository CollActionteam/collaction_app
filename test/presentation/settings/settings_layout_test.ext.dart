part of 'settings_layout_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpSettingsLayout([
    StackRouter? stackRouter,
  ]) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SettingsLayout(),
        ),
      ).withRouterScope(stackRouter),
    );
  }
}
