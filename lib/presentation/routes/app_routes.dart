import 'package:auto_route/annotations.dart';

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
    AutoRoute(page: AuthPage),
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: CrowdActionBrowsePage),
    AutoRoute(page: InSpotLightPage),
    AutoRoute(page: CrowdActionDetailsPage),
    AutoRoute(page: CrowdActionParticipantsPage),
    AutoRoute(page: ContactFormPage),
    AutoRoute(page: ComponentsDemoPage),
    AutoRoute(page: OnboardingPage),
    AutoRoute(page: DemoPage),
    AutoRoute(page: VerifiedPage),
  ],
)
class $AppRouter {}
