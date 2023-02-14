import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/presentation/auth/widgets/verify_phone.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/auth/auth_bloc.mocks.dart';

part 'verify_phone_test.ext.dart';

void main() {
  const channel = MethodChannel('com.julienvignali/phone_number');
  late AuthBloc authBloc;

  setUpAll(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return methodCall.arguments['string'] == '31 0612345678'
          ? {'isValid': true}
          : null;
    });

    // Auth Bloc
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenAnswer((_) => AuthState.initial());
    GetIt.I.registerSingleton<AuthBloc>(authBloc);
  });

  tearDownAll(() {
    channel.setMockMethodCallHandler(null);
    GetIt.I.unregister<AuthBloc>();
  });

  group('VerifyPhonePage tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpVerifyPhonePage(authBloc);
      await tester.pumpAndSettle();

      expect(find.byType(VerifyPhonePage), findsOneWidget);
    });

    testWidgets('PillButton disabled when invalid phone number',
        (WidgetTester tester) async {
      await tester.pumpVerifyPhonePage(authBloc);
      await tester.enterText(find.byType(TextFormField), '0012345678');
      await tester.pumpAndSettle();
      expect(find.text('+31'), findsOneWidget);
      expect(find.text('0012345678'), findsOneWidget);

      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        false,
      );
    });

    testWidgets('PillButton enabled when valid phone number',
        (WidgetTester tester) async {
      await tester.pumpVerifyPhonePage(authBloc);
      await tester.enterText(find.byType(TextFormField), '0612345678');
      await tester.pumpAndSettle();
      expect(find.text('+31'), findsOneWidget);
      expect(find.text('0612345678'), findsOneWidget);

      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        true,
      );
    });

    testWidgets('PillButton tap adds AuthEvent', (WidgetTester tester) async {
      await tester.pumpVerifyPhonePage(authBloc);
      await tester.enterText(find.byType(TextFormField), '0612345678');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PillButton));
      await tester.pumpAndSettle();

      verify(
        () => authBloc.add(AuthEvent.verifyPhone('31 0612345678')),
      ).called(1);
    });
  });
}
