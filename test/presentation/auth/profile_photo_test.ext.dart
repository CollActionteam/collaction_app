part of 'profile_photo_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpSelectProfilePhoto(
    AuthBloc authBloc,
    GoRouter router, {
    required Function() onSkip,
  }) async {
    await pumpWidget(
      BlocProvider<AuthBloc>(
        create: (context) => authBloc,
        child: MaterialApp(
          home: Scaffold(
            body: SelectProfilePhoto(
              onSkip: onSkip,
            ),
          ),
        ).withRouterScope(router),
      ),
    );
  }
}
