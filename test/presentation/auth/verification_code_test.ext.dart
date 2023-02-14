part of 'verification_code_test.dart';

extension WidgetX on WidgetTester {
  Future<void> pumpVerificationCode(AuthBloc authBloc,
      [int pinLength = 6]) async {
    await pumpWidget(
      BlocProvider<AuthBloc>(
        create: (context) => authBloc,
        child: MaterialApp(
          theme: lightTheme(),
          home: Scaffold(
            body: EnterVerificationCode(
              pinLength: pinLength,
            ),
          ),
        ),
      ),
    );
  }
}
