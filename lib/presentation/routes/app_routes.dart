import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation/profile/profile_screen.dart';
import '../../application/auth/auth_bloc.dart';
import '../../domain/core/i_settings_repository.dart';
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
import 'refresh_stream.dart';

part 'app_pages.dart';

class AppRouter {
  final AuthBloc authBloc;
  final ISettingsRepository settingsRepo;

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  final _unauthenticatedPaths = [
    AppPage.onBoarding.path,
    AppPage.unauthenticated.path,
    AppPage.auth.path,
    AppPage.verified.path,
  ];

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
                    ])
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
        refreshListenable: GoRouterAuthRefreshStream(authBloc.stream),
        redirect: (context, state) async {
          if (_unauthenticatedPaths.contains(state.location)) {
            return null;
          }

          final path = await authBloc.state.mapOrNull(
            unauthenticated: (_) async {
              final isOnboarded = await settingsRepo.getWasUserOnboarded();
              if (!isOnboarded) {
                return AppPage.onBoarding.path;
              }

              return AppPage.unauthenticated.path;
            },
          );

          if (path != null) {
            return path;
          }

          return null;
        },
      );

  AppRouter({
    required this.authBloc,
    required this.settingsRepo,
  });
}
