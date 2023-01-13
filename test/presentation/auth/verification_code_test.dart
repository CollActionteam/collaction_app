import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/presentation/auth/widgets/verification_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/auth/auth_bloc.mocks.dart';

part 'verification_code_test.ext.dart';

void main() {
  late AuthBloc authBloc;

  setUpAll(() {
    // Auth Bloc
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenAnswer(
      (_) => AuthState.initial(),
    );
    GetIt.I.registerSingleton<AuthBloc>(authBloc);
    registerFallbackValue(AuthEvent.resendCode());
  });

  tearDownAll(() {
    GetIt.I.unregister<AuthBloc>();
  });

  group('EnterVerificationCode tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpVerificationCode(authBloc);
      await tester.pumpAndSettle();

      expect(find.byType(EnterVerificationCode), findsOneWidget);
    });

    // pinLength isn't used in the EnterVerificationCode class
    testWidgets('pinLength', (WidgetTester tester) async {
      await tester.pumpVerificationCode(authBloc, 3);
      await tester.pumpAndSettle();

      expect(
        tester
            .firstWidget<EnterVerificationCode>(
                find.byType(EnterVerificationCode))
            .pinLength,
        3,
      );
    });

    testWidgets('resend code', (WidgetTester tester) async {
      await tester.pumpVerificationCode(authBloc);
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      verify(() => authBloc.add(AuthEvent.resendCode())).called(1);
    });

    testWidgets('submit PinInput', (WidgetTester tester) async {
      await tester.pumpVerificationCode(authBloc);
      await tester.enterText(find.byType(TextFormField), '123456');
      await tester.pumpAndSettle();

      verify(() => authBloc.add(AuthEvent.signInWithPhone('123456'))).called(1);
    });
  });
}
