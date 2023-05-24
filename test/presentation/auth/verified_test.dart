import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/presentation/auth/widgets/verified.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/user/profile/profile_bloc.mocks.dart';
import '../../utils/user.fixtures.dart';
import '../router.mocks.dart';

part 'verified_test.ext.dart';

void main() {
  late GoRouter goRouter;

  late ProfileBloc profileBloc;

  setUpAll(() {
    goRouter = RouteHelpers.setUpRouterStubs();

    // Profile Bloc
    profileBloc = MockProfileBloc();
    when(() => profileBloc.state).thenAnswer((_) => ProfileState.initial());
    GetIt.I.registerSingleton<ProfileBloc>(profileBloc);
  });

  tearDownAll(() {
    GetIt.I.unregister<ProfileBloc>();
  });

  group('VerifiedPage tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpVerifiedPage(goRouter);
      await tester.pump();

      expect(find.byType(VerifiedPage), findsOneWidget);
    });

    testWidgets('can render with name', (WidgetTester tester) async {
      when(() => profileBloc.state).thenAnswer(
        (_) => ProfileState(userProfile: testUserProfile),
      );
      await tester.pumpVerifiedPage(goRouter);
      await tester.pump();

      expect(find.text(testUserProfile.profile.fullName), findsOneWidget);
    });

    testWidgets('PillButton redirects to home', (WidgetTester tester) async {
      await tester.pumpVerifiedPage(goRouter);
      await tester.tap(find.byType(PillButton));
      await tester.pump();

      verify(() => goRouter.go(AppPage.home.path)).called(1);
    });

    testWidgets('TextButton redirects to home', (WidgetTester tester) async {
      await tester.pumpVerifiedPage(goRouter);
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      verify(() => goRouter.go(AppPage.home.path)).called(1);
    });
  });
}
