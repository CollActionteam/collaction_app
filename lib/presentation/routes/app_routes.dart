import 'package:auto_route/annotations.dart';

import '../authentication/register_phone_number_screen.dart';
import '../authentication/verify_code_screen.dart';
import '../contact_form/contact_form_screen.dart';
import '../crowd_action/crowd_action_browse.dart';
import '../home/home_screen.dart';


@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: CrowdActionBrowsePage),
    AutoRoute(page: ContactFormPage),
    AutoRoute(page: RegisterPhoneNumberPage),
    AutoRoute(page: VerifyCodePage),
  ],
)
class $AppRouter {}
