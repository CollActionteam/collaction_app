import 'package:auto_route/annotations.dart';

import '../contact_form/contact_form_screen.dart';
import '../crowd_action/crowd_action_browse.dart';
import '../home/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: CrowdActionBrowsePage),
    AutoRoute(page: ContactFormPage),
  ],
)
class $AppRouter {}
