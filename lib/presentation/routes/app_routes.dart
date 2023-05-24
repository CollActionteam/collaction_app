import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/profile/profile_screen.dart';
import '../auth/auth_screen.dart';
import '../auth/unauthenticated_screen.dart';
import '../auth/widgets/verified.dart';
import '../contact_form/contact_form_screen.dart';
import '../crowdaction/crowdaction_browse/crowdaction_browse_screen.dart';
import '../crowdaction/crowdaction_comments/crowdaction_comments_page.dart';
import '../crowdaction/crowdaction_details/crowdaction_details_screen.dart';
import '../crowdaction/crowdaction_home/crowdaction_home_screen.dart';
import '../crowdaction/crowdaction_participants/crowdaction_participants_screen.dart';
import '../demo/components_demo/components_demo_screen.dart';
import '../demo/demo_screen.dart';
import '../home/home_screen.dart';
import '../licenses/licenses_page.dart';
import '../onboarding/onboarding_screen.dart';
import '../settings/settings_layout.dart';
import '../settings/settings_screen.dart';
import '../shared_widgets/web_view_page.dart';

part 'app_pages.dart';

class AppRouter {
  // final ISettingsRepository settingsRepository;
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (
              BuildContext context,
              GoRouterState state,
              StatefulNavigationShell navigationShell,
            ) {
              return HomePage(navigationShell: navigationShell);
            },
            branches: [
              StatefulShellBranch(routes: [
                GoRoute(
                  path: AppPage.home.path,
                  pageBuilder: (_, __) =>
                      const NoTransitionPage(child: CrowdActionHomeScreen()),
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: AppPage.userProfile.path,
                  pageBuilder: (_, __) =>
                      NoTransitionPage(child: UserProfilePage()),
                ),
              ]),
              StatefulShellBranch(routes: [
                GoRoute(
                  path: AppPage.demoPage.path,
                  pageBuilder: (_, __) => NoTransitionPage(child: DemoPage()),
                  routes: [
                    GoRoute(
                      path: 'components',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (_, __) => const ComponentsDemoPage(),
                    ),
                    GoRoute(
                      path: 'comments',
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (_, __) => const CrowdActionCommentsPage(),
                    ),
                  ]
                )
              ])
            ],
          ),
          GoRoute(
            path: AppPage.crowdActionsList.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {
              return CrowdActionBrowsePage();
            },
          ),
          GoRoute(
            path: '${AppPage.crowdActionDetails.path}/:id',
            parentNavigatorKey: _rootNavigatorKey,
            builder: (BuildContext context, GoRouterState state) {

              return CrowdActionDetailsPage(
                crowdActionId: state.pathParameters['id'],
              );
            },
          ),
          GoRoute(
            path: AppPage.crowdActionParticipants.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, state) => CrowdActionParticipantsPage(
              crowdActionId: state.extra! as String,
            ),
          ),
          GoRoute(
            path: AppPage.onBoarding.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const OnboardingPage(),
          ),
          GoRoute(
            path: AppPage.verified.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const VerifiedPage(),
          ),
          GoRoute(
            path: AppPage.auth.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const AuthPage(),
          ),
          GoRoute(
            path: AppPage.settings.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const SettingsPage(),
          ),
          GoRoute(
            path: AppPage.licenses.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const LicensesPage(),
          ),
          GoRoute(
            path: AppPage.settingsLayout.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const SettingsLayout(),
          ),
          GoRoute(
            path: AppPage.contactForm.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => const ContactFormPage(),
          ),
          GoRoute(
            path: AppPage.unauthenticated.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, __) => UnauthenticatedPage(),
          ),
          GoRoute(
            path: AppPage.webView.path,
            parentNavigatorKey: _rootNavigatorKey,
            builder: (_, state) => WebViewPage(
              url: state.extra?.toString() ?? "",
              title: state.pathParameters['title']?.toString() ?? "",
            ),
          )
        ],
        debugLogDiagnostics: true,
        initialLocation: AppPage.home.path,
        // redirect: (context, state) async {
        //   final isNotOnBoarded = state.location != AppPage.onBoarding.path &&
        //       !(await settingsRepository.getWasUserOnboarded());
        //
        //   if (isNotOnBoarded) {
        //     return AppPage.onBoarding.path;
        //   }
        //
        //   return null;
        // },
      );

  AppRouter(/*this.settingsRepository*/);
}
