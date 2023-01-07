import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/shared_widgets/content_placeholder.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/auth/auth_bloc.mocks.dart';
import '../../test_helper.dart';

void main() {
  late AuthBloc authBloc;

  setUpAll(() {
    authBloc = MockAuthBloc();
    GetIt.I.registerSingleton<AuthBloc>(authBloc);
  });

  tearDownAll(() {
    GetIt.I.unregister<AuthBloc>();
  });

  group('ContentPlaceholder test:', () {
    const Color textColor = Color(0x90ABCDEF);
    const String text = "text";
    const String extraText =
        'We’re working hard on adding new content. In the meantime we have a happy dog for you \ud83d\ude09';

    testWidgets('can render', (WidgetTester tester) async {
      when(() => authBloc.state).thenAnswer((_) => AuthState.unauthenticated());
      await buildAndPump(
        tester: tester,
        widget: const ContentPlaceholder(
          textColor: textColor,
          description: text,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ContentPlaceholder), findsOneWidget);
      expect(find.text(text), findsOneWidget);
      expect(
        (tester.firstWidget(find.text(text)) as Text).style!.color,
        textColor,
      );
    });

    testWidgets('can render unauthenticated', (WidgetTester tester) async {
      when(() => authBloc.state).thenAnswer((_) => AuthState.unauthenticated());
      await buildAndPump(
        tester: tester,
        widget: const ContentPlaceholder(
          textColor: textColor,
          description: text,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(extraText), findsOneWidget);
      expect(
        (tester.firstWidget(find.text(extraText)) as Text).style!.color,
        textColor,
      );
    });

    testWidgets('can render authenticated', (WidgetTester tester) async {
      when(() => authBloc.state)
          .thenAnswer((_) => AuthState.authenticated(User.anonymous));
      await buildAndPump(
        tester: tester,
        widget: const ContentPlaceholder(
          textColor: textColor,
          description: text,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(extraText), findsNothing);
    });
  });
}
