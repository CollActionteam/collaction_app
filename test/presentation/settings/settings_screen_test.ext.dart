part of 'settings_screen_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpSettingsPage([
    StackRouter? stackRouter,
  ]) async {
    await pumpWidget(
      MaterialApp(
        theme: lightTheme(),
        home: Scaffold(
          body: MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (_) => getIt<AuthBloc>(),
              ),
              BlocProvider<ProfileBloc>(
                create: (_) => getIt<ProfileBloc>(),
              ),
            ],
            child: SettingsPage(),
          ),
        ),
      ).withRouterScope(stackRouter),
    );
  }
}
