part of 'confirm_participation_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpConfirmParticipation(
      StackRouter stackRouter,
      ParticipationBloc participationBloc,
      CrowdAction crowdAction,
      List<CommitmentOption> selectedCommitments) async {
    await pumpWidget(
      BlocProvider(
        create: (_) => participationBloc,
        child: MaterialApp(
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
