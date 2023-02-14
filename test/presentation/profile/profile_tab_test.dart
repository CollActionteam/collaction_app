import 'package:collaction_app/application/user/profile_tab/profile_tab_bloc.dart';
import 'package:collaction_app/domain/user/user.dart';
import 'package:collaction_app/presentation/profile/widget/badges_tab.dart';
import 'package:collaction_app/presentation/profile/widget/commitments_tab.dart';
import 'package:collaction_app/presentation/profile/widget/crowdactions_tab.dart';
import 'package:collaction_app/presentation/profile/widget/profile_tab.dart';
import 'package:collaction_app/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/user/profile_tab/profile_tab_bloc.mocks.dart';
import '../../utils/user.fixtures.dart';

part 'profile_tab_test.ext.dart';

void main() {
  late ProfileTabBloc profileTabBloc;

  setUpAll(() {
    profileTabBloc = MockProfileTabBloc();
    when(() => profileTabBloc.state).thenAnswer(
      (_) => ProfileTabState.initial(),
    );
    GetIt.I.registerSingleton<ProfileTabBloc>(profileTabBloc);
  });

  tearDownAll(() {
    GetIt.I.unregister<ProfileTabBloc>();
  });

  group('UserProfileTab tests:', () {
    testWidgets(
      'can render, tapping on tab brings up correct view',
      (WidgetTester tester) async {
        await tester.pumpProfileTab(profileTabBloc);
        await tester.pumpAndSettle();

        expect(find.byType(UserProfileTab), findsOneWidget);
        TabBar tabBar = tester.firstWidget<TabBar>(find.byType(TabBar));
        expect(tabBar.controller?.length, 3);
        expect(tabBar.controller?.index, 1);

        await tester.tap(find.text('Badges'));
        await tester.pumpAndSettle();
        expect(find.byType(BadgesTab), findsOneWidget);

        await tester.tap(find.text('CrowdActions'));
        await tester.pumpAndSettle();
        expect(find.byType(CrowdActionsTab), findsOneWidget);

        await tester.tap(find.text('Commitments'));
        await tester.pumpAndSettle();
        expect(find.byType(CommitmentsTab), findsOneWidget);
      },
    );

    testWidgets('can render with test user', (WidgetTester tester) async {
      await tester.pumpProfileTab(profileTabBloc, user: testUser);
      await tester.pumpAndSettle();

      expect(find.byType(UserProfileTab), findsOneWidget);
    });
  });
}
