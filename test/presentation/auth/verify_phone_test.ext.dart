part of 'verify_phone_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpVerifyPhonePage(AuthBloc authBloc) async {
    await pumpWidget(
      BlocProvider<AuthBloc>(
        create: (context) => authBloc,
        child: MaterialApp(
          theme: lightTheme(),
          home: Scaffold(
            body: VerifyPhonePage(),
          ),
        ),
      ),
    );
  }
}
