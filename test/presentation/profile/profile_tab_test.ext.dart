part of 'profile_tab_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpProfileTab(ProfileTabBloc profileTabBloc,
      {User? user}) async {
    await pumpWidget(
      BlocProvider(
        create: (context) => profileTabBloc,
        child: MaterialApp(
          theme: lightTheme(),
          home: Scaffold(
            body: UserProfileTab(user: user),
          ),
        ),
      ),
    );
  }
}
