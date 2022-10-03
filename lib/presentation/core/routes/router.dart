import 'package:collaction_app/domain/core/i_settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/crowdaction/crowdaction.dart';
import '../../auth/auth_screen.dart';
import '../../auth/widgets/verified.dart';
import '../../contact_form/widgets/contact_form.dart';
import '../../crowdaction/crowdaction_browse/crowdaction_browse_screen.dart';
import '../../crowdaction/crowdaction_details/crowdaction_details_screen.dart';
import '../../crowdaction/crowdaction_home/crowdaction_home_screen.dart';
import '../../demo/components_demo/components_demo_screen.dart';
import '../../demo/demo_screen.dart';
import '../../home/captive_screen.dart';
import '../../home/home_screen.dart';
import '../../onboarding/onboarding_screen.dart';
import '../../profile/profile_screen.dart';
import '../../settings/settings_layout.dart';
import '../../settings/settings_screen.dart';
import '../../shared_widgets/web_view_page.dart';
import 'app_page.dart';

class AppRouter {
  final ISettingsRepository settingsRepository;
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        routes: [
          ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return HomePage(child: child);
            },
            routes: <RouteBase>[
              GoRoute(
                path: AppPage.home.toPath,
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: CrowdActionHomeScreen()),
              ),
              GoRoute(
                path: AppPage.userProfile.toPath,
                pageBuilder: (_, __) =>
                    NoTransitionPage(child: UserProfilePage()),
              ),
              GoRoute(
                path: AppPage.demoPage.toPath,
                pageBuilder: (_, __) => NoTransitionPage(child: DemoPage()),
              )
            ],
          ),
          GoRoute(
            path: AppPage.crowdActionsList.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return const CrowdActionBrowsePage();
            },
          ),
          GoRoute(
            path: AppPage.crowdActionDetails.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              final extra = state.extra as Map<String, Object?>? ?? {};
              final crowdAction = extra['crowdAction'] as CrowdAction?;
              final viewOnly = extra['viewOnly'] as bool? ?? false;

              return CrowdActionDetailsPage(
                crowdAction: crowdAction,
                crowdActionId: crowdAction?.id,
                viewOnly: viewOnly,
              );
            },
          ),
          GoRoute(
            path: AppPage.onBoarding.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const OnboardingPage(),
          ),
          GoRoute(
            path: AppPage.componentsDemo.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const ComponentsDemoPage(),
          ),
          GoRoute(
            path: AppPage.verified.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const VerifiedPage(),
          ),
          GoRoute(
            path: AppPage.captive.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const CaptivePage(),
          ),
          GoRoute(
            path: AppPage.auth.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const AuthPage(),
          ),
          GoRoute(
            path: AppPage.settings.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const SettingsPage(),
          ),
          GoRoute(
            path: AppPage.licenses.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const LicensePage(),
          ),
          GoRoute(
            path: AppPage.settingsLayout.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const SettingsLayout(),
          ),
          GoRoute(
            path: AppPage.contactForm.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const ContactForm(),
          ),
          GoRoute(
            path: AppPage.webView.toPath,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, state) => WebViewPage(
              url: state.extra?.toString() ?? "",
              title: state.params['title']?.toString() ?? "",
            ),
          )
        ],
        debugLogDiagnostics: true,
        initialLocation: AppPage.home.toPath,
        redirect: (context, state) async {
          final isNotOnBoarded = state.location != AppPage.onBoarding.toPath &&
              !(await settingsRepository.getWasUserOnboarded());

          if (isNotOnBoarded) {
            return AppPage.onBoarding.toPath;
          }

          return null;
        },
      );

  AppRouter(this.settingsRepository);
}
