import 'dart:io';

import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/application/settings/build_information/build_information_bloc.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:collaction_app/presentation/routes/app_routes.dart';
import 'package:collaction_app/presentation/settings/settings_screen.dart';
import 'package:collaction_app/presentation/settings/widgets/build_information_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/auth/auth_bloc.mocks.dart';
import '../../application/settings/build_information_bloc.mocks.dart';
import '../../application/user/profile/profile_bloc.mocks.dart';
import '../../utils/user.fixtures.dart';
import '../router.mocks.dart';

part 'settings_screen_test.ext.dart';

void main() {
  late GoRouter goRouter;
  late AuthBloc authBloc;
  late ProfileBloc profileBloc;
  late BuildInformationBloc buildInformationBloc;

  final channels = [
    MethodChannel(
      Platform.isLinux
          ? 'plugins.flutter.io/url_launcher_linux'
          : Platform.isWindows
              ? 'plugins.flutter.io/url_launcher_windows'
              : 'plugins.flutter.io/url_launcher_macos',
    ),
    MethodChannel('plugins.flutter.io/url_launcher')
  ];

  setUp(() async {
    for (final channel in channels) {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        return methodCall.method == 'canLaunch' ? true : null;
      });
    }
  });

  tearDown(() {
    for (final channel in channels) {
      channel.setMockMethodCallHandler(null);
    }
  });

  setUpAll(() {
    goRouter = RouteHelpers.setUpRouterStubs();

    // Auth Bloc
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenAnswer((_) => AuthState.initial());
    GetIt.I.registerSingleton<AuthBloc>(authBloc);

    // Profile Bloc
    profileBloc = MockProfileBloc();
    when(() => profileBloc.state).thenAnswer((_) => ProfileState.initial());
    GetIt.I.registerSingleton<ProfileBloc>(profileBloc);
    registerFallbackValue(GetUserProfile());

    // Build Information Bloc
    buildInformationBloc = MockBuildInformationBloc();
    when(() => buildInformationBloc.state).thenAnswer(
      (_) => BuildInformationState.fetched(
        BuildInformation(
          buildNumber: 'tBuildNumber',
          version: 'tVersion',
        ),
      ),
    );
    GetIt.I.registerSingleton<BuildInformationBloc>(buildInformationBloc);
  });

  tearDownAll(() {
    GetIt.I.unregister<AuthBloc>();
    GetIt.I.unregister<ProfileBloc>();
    GetIt.I.unregister<BuildInformationBloc>();
  });

  group('SettingsPage tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('onTap, "Contact Us" button routes to ContactForm',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Contact us'));
      verify(
        () => goRouter.push(AppPage.contactForm.path),
      ).called(1);
    });

    testWidgets('onTap, "Onboarding" button routes to Onboarding',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Onboarding'));
      verify(
        () => goRouter.push(AppPage.onBoarding.path),
      ).called(1);
    });

    testWidgets('onTap, "Open source libraries" button routes to Licenses',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open source libraries'));
      verify(
        () => goRouter.push(AppPage.licenses.path),
      ).called(1);
    });

    testWidgets('onTap, "Terms of use" button opens terms webpage',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      await tester.runAsync(() async {
        await tester.tap(find.text('Terms of use'));
        await tester.pumpAndSettle();
      });

      verify(
        () => goRouter.push(
          AppPage.webView.path,
          extra: 'https://www.collaction.org/terms',
        ),
      ).called(1);
    });

    testWidgets('onTap, "Privacy policy" button opens privacy webpage',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      await tester.runAsync(() async {
        await tester.scrollUntilVisible(
          find.text(
            'Privacy policy',
            skipOffstage: false,
          ),
          15,
        );
        await tester.tap(find.text('Privacy policy'));
        await tester.pumpAndSettle();
      });

      verify(
        () => goRouter.push(
          AppPage.webView.path,
          extra: 'https://www.collaction.org/privacy',
        ),
      ).called(1);
    });

    testWidgets('"Log out" button not available when not logged in',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Log out',
          skipOffstage: false,
        ),
        findsNothing,
      );
    });

    testWidgets('onTap, "Log out" button starts logout event',
        (WidgetTester tester) async {
      when(() => profileBloc.state)
          .thenAnswer((_) => ProfileState(userProfile: testUserProfile));

      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text(
          'Log out',
          skipOffstage: false,
        ),
        15,
      );
      await tester.tap(find.text('Log out'));

      final capturedPops = verify(() => goRouter.pop());
      expect(capturedPops.callCount, 1);

      verify(() => authBloc.add(AuthEvent.signedOut()));

      final profileEvents = verify(() => profileBloc.add(any()));
      expect(profileEvents.callCount, 1);
    });

    testWidgets('BuildInformationTile renders when fetched',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      expect(
        find.byType(
          BuildInformationTile,
          skipOffstage: false,
        ),
        findsOneWidget,
      );
    });

    testWidgets('BuildInformationTile does not render when loading',
        (WidgetTester tester) async {
      when(() => buildInformationBloc.state).thenAnswer(
        (_) => BuildInformationState.loading(),
      );

      await tester.pumpSettingsPage(goRouter);
      await tester.pumpAndSettle();

      expect(
        find.byType(
          BuildInformationTile,
          skipOffstage: false,
        ),
        findsNothing,
      );
    });
  });
}
