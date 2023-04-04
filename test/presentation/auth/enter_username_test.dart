import 'package:bloc_test/bloc_test.dart';
import 'package:collaction_app/application/username/username_bloc.dart';
import 'package:collaction_app/presentation/auth/widgets/enter_username.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/username/username_bloc.mocks.dart';
import '../../test_helper.dart';

void main() {
  late UsernameBloc usernameBloc;

  setUpAll(() {
    usernameBloc = MockUsernameBloc();
    when(() => usernameBloc.state).thenAnswer((_) => UsernameState.initial());
    GetIt.I.registerSingleton<UsernameBloc>(usernameBloc);
    registerFallbackValue(
      UsernameEvent.updateUsername(
        firstName: 'Coll',
        lastName: 'Action',
      ),
    );
  });

  tearDownAll(() {
    GetIt.I.unregister<UsernameBloc>();
  });

  group('EnterUserName tests:', () {
    testWidgets('initial state can render', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: EnterUserName(onDone: (_) {}));
      await tester.pumpAndSettle();

      expect(find.byType(EnterUserName), findsOneWidget);
      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isLoading,
        false,
      );
    });

    testWidgets('first name validation working', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: EnterUserName(onDone: (_) {}));

      await tester.enterText(find.byType(TextFormField).first, 'C');
      await tester.pumpAndSettle();
      expect(
        find.text('First name should be between 2 and 20 characters long'),
        findsOneWidget,
      );

      await tester.enterText(find.byType(TextFormField).first, 'Coll');
      await tester.pumpAndSettle();
      expect(
        find.text('First name should be between 2 and 20 characters long'),
        findsNothing,
      );
      expect(
        find.text('First name should start with a letter'),
        findsNothing,
      );
    });

    testWidgets('last name validation working', (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: EnterUserName(onDone: (_) {}));

      await tester.enterText(find.byType(TextFormField).last, 'Act');
      await tester.pumpAndSettle();
      expect(
        find.text('Last name should be between 4 and 20 characters long'),
        findsOneWidget,
      );

      await tester.enterText(find.byType(TextFormField).last, 'Action');
      await tester.pumpAndSettle();
      expect(
        find.text('Last name should be between 4 and 20 characters long'),
        findsNothing,
      );
      expect(
        find.text('Last name should start with a letter'),
        findsNothing,
      );
    });

    testWidgets('PillButton disabled when username invalid',
        (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: EnterUserName(onDone: (_) {}));
      await tester.enterText(find.byType(TextFormField).first, 'C');
      await tester.enterText(find.byType(TextFormField).last, 'Act');
      await tester.pumpAndSettle();
      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        false,
      );
    });

    testWidgets('PillButton tap adds valid username to UsernameBloc',
        (WidgetTester tester) async {
      await buildAndPump(tester: tester, widget: EnterUserName(onDone: (_) {}));
      await tester.enterText(find.byType(TextFormField).first, 'Coll');
      await tester.enterText(find.byType(TextFormField).last, 'Action');
      await tester.pumpAndSettle();

      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        true,
      );
      await tester.tap(find.byType(PillButton));
      verify(() => usernameBloc.add(any())).called(1);
    });

    testWidgets('updateInProgress state rendering/interactions',
        (WidgetTester tester) async {
      when(() => usernameBloc.state).thenAnswer(
        (_) => UsernameState.updateInProgress(),
      );
      await buildAndPump(tester: tester, widget: EnterUserName(onDone: (_) {}));
      await tester.enterText(find.byType(TextFormField).first, 'Coll');
      await tester.enterText(find.byType(TextFormField).last, 'Action');
      await tester.pump();
      await tester.tap(find.byType(PillButton));
      verifyNever(() => usernameBloc.add(any()));
      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isLoading,
        true,
      );
      expect(
        tester.firstWidget<PillButton>(find.byType(PillButton)).isEnabled,
        false,
      );
    });

    testWidgets('updateSuccess event calls onDone',
        (WidgetTester tester) async {
      whenListen(
        usernameBloc,
        Stream.fromIterable([UsernameState.updateSuccess('Coll Action')]),
      );
      bool onDoneCalled = false;
      await buildAndPump(
        tester: tester,
        widget: EnterUserName(onDone: (_) => onDoneCalled = true),
      );
      await tester.enterText(find.byType(TextFormField).first, 'Coll');
      await tester.enterText(find.byType(TextFormField).last, 'Action');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(PillButton));
      expect(onDoneCalled, true);
    });
  });
}
