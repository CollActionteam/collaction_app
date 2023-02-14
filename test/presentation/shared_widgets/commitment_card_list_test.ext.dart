part of 'commitment_card_list_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpCommitmentCardList(
    bool isEnded,
    List<CommitmentOption>? commitmentOptions,
    List<CommitmentOption> selectedCommitments,
    ParticipationBloc participationBloc,
  ) async {
    await pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ParticipationBloc>(
            create: (context) => participationBloc,
          )
        ],
        child: MaterialApp(
          theme: lightTheme(),
          home: Scaffold(
            body: CommitmentCardList(
              isEnded: isEnded,
              commitmentOptions: commitmentOptions,
              selectedCommitments: selectedCommitments,
            ),
          ),
        ),
      ),
    );
  }
}
