part of 'confirm_participation_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpConfirmParticipation(
      StackRouter stackRouter,
      ParticipationBloc participationBloc,
      CrowdAction crowdAction,
      List<Commitment> selectedCommitments) async {
    await pumpWidget(
      BlocProvider(
        create: (_) => participationBloc,
        child: MaterialApp(
          theme: lightTheme(),
          home: Scaffold(
            body: ConfirmParticipation(
                crowdAction: crowdAction,
                selectedCommitments: selectedCommitments),
          ),
        ).withRouterScope(stackRouter),
      ),
    );
  }
}
