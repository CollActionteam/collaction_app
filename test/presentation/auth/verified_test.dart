import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/presentation/auth/widgets/verified.dart';
import 'package:collaction_app/presentation/shared_widgets/pill_button.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/user/profile/profile_bloc.mocks.dart';
import '../../utils/user.fixtures.dart';
import '../router.mocks.dart';

part 'verified_test.ext.dart';

void main() {
  late StackRouter stackRouter;

  late ProfileBloc profileBloc;

  setUpAll(() {
    stackRouter = RouteHelpers.setUpRouterStubs();
    when(() => stackRouter.replaceAll([const HomeRoute()])).thenAnswer(
      (_) async {},
    );

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
      await tester.pumpVerifiedPage(stackRouter);
      await tester.pump();

      expect(find.byType(VerifiedPage), findsOneWidget);
    });

    testWidgets('can render with name', (WidgetTester tester) async {
      when(() => profileBloc.state).thenAnswer(
        (_) => ProfileState(userProfile: testUserProfile),
      );
      await tester.pumpVerifiedPage(stackRouter);
      await tester.pump();

      expect(find.text(testUserProfile.profile.fullName), findsOneWidget);
    });

    testWidgets('PillButton redirects to home', (WidgetTester tester) async {
      await tester.pumpVerifiedPage(stackRouter);
      await tester.tap(find.byType(PillButton));
      await tester.pump();

      verify(() => stackRouter.replaceAll([const HomeRoute()])).called(1);
    });

    testWidgets('TextButton redirects to home', (WidgetTester tester) async {
      await tester.pumpVerifiedPage(stackRouter);
      await tester.tap(find.byType(TextButton));
      await tester.pump();

      verify(() => stackRouter.replaceAll([const HomeRoute()])).called(1);
    });
  });
}
