import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/settings/settings_layout.dart';
import 'package:collaction_app/presentation/settings/settings_page.dart';

import '../../../presentation/crowd_action/pages/participants.dart';
import '../../../presentation/user/user_profile_page.dart';
import '../auth/auth_screen.dart';
import '../auth/pages/verified.dart';
import '../contact_form/contact_form_screen.dart';
import '../crowd_action/crowd_action_browse.dart';
import '../crowd_action/pages/crowd_action_details.dart';
import '../crowd_action/pages/in_spot_light.dart';
import '../crowd_action/pages/participants.dart';
import '../demo/components_demo/components_demo_screen.dart';
import '../demo/demo_screen.dart';
import '../home/home_screen.dart';
import '../onboarding/onboarding.dart';

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
            AutoRoute(path: '', page: InSpotLightPage),
            AutoRoute(path: 'details', page: CrowdActionDetailsPage),
            AutoRoute(path: 'participants', page: CrowdActionParticipantsPage),
            AutoRoute(path: 'view-all', page: CrowdActionBrowsePage),
          ],
        ),
        AutoRoute(
          path: 'user',
          name: 'UserProfileRouter',
          page: UserProfilePage,
        ),
        AutoRoute(
          path: 'demo',
          name: 'DemoScreenRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: '', page: DemoPage),
            AutoRoute(path: 'contact-form', page: ContactFormPage),
            AutoRoute(path: 'components-demo', page: ComponentsDemoPage),
            AutoRoute(path: 'onboarding', page: OnboardingPage),
            AutoRoute(path: 'auth', page: AuthPage),
            AutoRoute(path: 'verified', page: VerifiedPage),
          ],
        ),
      ],
    ),
    AutoRoute(path: 'auth', page: AuthPage),
    AutoRoute(path: 'verified', page: VerifiedPage),
    AutoRoute(path: 'settings-page', page: SettingsPage),
    AutoRoute(path: 'settings-layout', page: SettingsLayout),
  ],
)
class $AppRouter {}
