import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../../../presentation/profile/profile_screen.dart';
import '../auth/auth_screen.dart';
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
import '../menu/menu_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../shared_widgets/web_view_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      initial: true,
      children: [
        AutoRoute(
          path: 'browse-crowdactions',
          name: 'CrowdactionRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: CrowdActionHomeScreen),
            AutoRoute(path: 'details', page: CrowdActionDetailsPage),
            AutoRoute(path: 'participants', page: CrowdActionParticipantsPage),
            AutoRoute(path: 'view-all', page: CrowdActionBrowsePage),
          ],
        ),
        AutoRoute(
          path: 'user',
          name: 'UserProfileRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: UserProfilePage,
            ),
            AutoRoute(
              path: 'details',
              page: CrowdActionDetailsPage,
            ),
          ],
        ),
        AutoRoute(
          path: 'demo',
          name: 'DemoScreenRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: DemoPage),
            AutoRoute(path: 'components-demo', page: ComponentsDemoPage),
            AutoRoute(path: 'onboarding', page: OnboardingPage),
            AutoRoute(path: 'verified', page: VerifiedPage),
            AutoRoute(path: 'comments', page: CrowdActionCommentsPage),
          ],
        ),
        AutoRoute(
          path: 'menu',
          name: 'MenuScreenRouter',
          page: EmptyRouterPage,
          children: [AutoRoute(path: '', page: MenuPage)],
        ),
      ],
    ),
    AutoRoute(path: 'onboarding', page: OnboardingPage),
    AutoRoute(path: 'auth', page: AuthPage),
    AutoRoute(path: 'verified', page: VerifiedPage),
    AutoRoute(path: 'licenses-page', page: LicensesPage),
    AutoRoute(path: 'contact-form', page: ContactFormPage),
    AutoRoute(path: 'webview', page: WebViewPage),
  ],
)
class $AppRouter {}
