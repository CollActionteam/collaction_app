import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/application/auth/auth_bloc.dart';
import 'package:collaction_app/application/settings/build_information/build_information_bloc.dart';
import 'package:collaction_app/application/user/profile/profile_bloc.dart';
import 'package:collaction_app/domain/settings/build_information.dart';
import 'package:collaction_app/infrastructure/core/injection.dart';
import 'package:collaction_app/presentation/settings/settings_screen.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';
import 'package:collaction_app/presentation/settings/widgets/build_information_tile.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';

import '../../application/auth/auth_bloc.mocks.dart';
import '../../application/settings/build_information_bloc.mocks.dart';
import '../../application/user/profile/profile_bloc.mocks.dart';
import '../../test_utilities.dart';
import '../../utils/user.fixtures.dart';
import '../router.mocks.dart';

part 'settings_screen_test.ext.dart';

void main() {
  late StackRouter stackRouter;
  late AuthBloc authBloc;
  late ProfileBloc profileBloc;
  late BuildInformationBloc buildInformationBloc;

  const channel = MethodChannel('plugins.flutter.io/url_launcher_windows');

  setUp(() async {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return methodCall.method == 'canLaunch' ? true : null;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  setUpAll(() {
    stackRouter = RouteHelpers.setUpRouterStubs();

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

    dotenv.testLoad(fileInput: tDotEnv);
  });

  tearDownAll(() {
    GetIt.I.unregister<AuthBloc>();
    GetIt.I.unregister<ProfileBloc>();
    GetIt.I.unregister<BuildInformationBloc>();
  });

  group('SettingsPage tests:', () {
    testWidgets('can render', (WidgetTester tester) async {
      await tester.pumpSettingsPage(stackRouter);
      await tester.pumpAndSettle();

      expect(find.byType(SettingsPage), findsOneWidget);
    });

    testWidgets('onTap, "Contact Us" button routes to ContactForm',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(stackRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Contact us'));
      final capturedRoutes =
          verify(() => stackRouter.push(captureAny())).captured;

      expect(capturedRoutes.length, 1);
      expect(capturedRoutes.first, isA<ContactFormRoute>());
    });

    testWidgets('onTap, "Onboarding" button routes to Onboarding',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(stackRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Onboarding'));
      final capturedRoutes =
          verify(() => stackRouter.push(captureAny())).captured;

      expect(capturedRoutes.length, 1);
      expect(capturedRoutes.first, isA<OnboardingRoute>());
    });

    testWidgets('onTap, "Open source libraries" button routes to Licenses',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(stackRouter);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open source libraries'));
      final capturedRoutes =
          verify(() => stackRouter.push(captureAny())).captured;

      expect(capturedRoutes.length, 1);
      expect(capturedRoutes.first, isA<LicensesRoute>());
    });

    testWidgets('onTap, "Terms of use" button opens terms webpage',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(stackRouter);
      await tester.pumpAndSettle();

      await tester.runAsync(() async {
        await tester.tap(find.text('Terms of use'));
        await tester.pumpAndSettle();
      });

      final capturedRoutes =
          verify(() => stackRouter.push(captureAny())).captured;

      expect(capturedRoutes.length, 1);
      expect(capturedRoutes.first, isA<WebViewRoute>());

      final route = capturedRoutes.first as WebViewRoute;
      expect(route.args?.url, 'https://www.collaction.org/terms');
    });

    testWidgets('onTap, "Privacy policy" button opens privacy webpage',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(stackRouter);
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

      final capturedRoutes =
          verify(() => stackRouter.push(captureAny())).captured;

      expect(capturedRoutes.length, 1);
      expect(capturedRoutes.first, isA<WebViewRoute>());

      final route = capturedRoutes.first as WebViewRoute;
      expect(route.args?.url, 'https://www.collaction.org/privacy');
    });

    testWidgets('"Log out" button not available when not logged in',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(stackRouter);
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

      await tester.pumpSettingsPage(stackRouter);
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text(
          'Log out',
          skipOffstage: false,
        ),
        15,
      );
      await tester.tap(find.text('Log out'));

      final capturedPops = verify(() => stackRouter.pop());
      expect(capturedPops.callCount, 1);

      verify(() => authBloc.add(AuthEvent.signedOut()));

      final profileEvents = verify(() => profileBloc.add(any()));
      expect(profileEvents.callCount, 1);
    });

    testWidgets('BuildInformationTile renders when fetched',
        (WidgetTester tester) async {
      await tester.pumpSettingsPage(stackRouter);
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

      await tester.pumpSettingsPage(stackRouter);
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
