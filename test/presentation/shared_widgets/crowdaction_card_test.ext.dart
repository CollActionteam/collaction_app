part of 'crowdaction_card_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpCrowdactionCard(
    CrowdAction crowdAction, [
    GoRouter? goRouter,
  ]) async {
    await pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CrowdActionCard(
            crowdAction: crowdAction,
          ),
        ),
      ).withRouterScope(goRouter),
    );
  }
}
