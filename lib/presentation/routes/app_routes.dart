import 'package:auto_route/annotations.dart';

import '../authentication/register_phone_number_screen.dart';
import '../authentication/verify_code_screen.dart';
import '../contact_form/contact_form_screen.dart';
import '../crowd_action/crowd_action_browse.dart';
import '../crowd_action/crowd_action_details.dart';
import '../demo/components_demo/components_demo_screen.dart';
import '../demo/demo_screen.dart';
import '../home/home_screen.dart';
import '../onboarding/onboarding.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: CrowdActionBrowsePage),
    AutoRoute(page: ContactFormPage),
    AutoRoute(page: RegisterPhoneNumberPage),
    AutoRoute(page: VerifyCodePage),
    AutoRoute(page: ComponentsDemoPage),
    AutoRoute(page: OnboardingPage),
    AutoRoute(page: CrowdActionDetailsPage),
    AutoRoute(page: DemoPage),
  ],
)
class $AppRouter {}
