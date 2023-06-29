part of 'settings_screen_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpSettingsPage([
    GoRouter? goRouter,
  ]) async {
    await pumpWidget(
      MaterialApp(
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
      ).withRouterScope(goRouter),
    );
  }
}
