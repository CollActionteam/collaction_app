part of 'crowdaction_card_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpCrowdactionCard(
    CrowdAction crowdAction, [
    StackRouter? stackRouter,
  ]) async {
    await pumpWidget(
      MaterialApp(
        theme: lightTheme(),
        home: Scaffold(
          body: CrowdActionCard(
            crowdAction: crowdAction,
          ),
        ),
      ).withRouterScope(stackRouter),
    );
  }
}
