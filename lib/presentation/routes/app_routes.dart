import 'package:auto_route/annotations.dart';

import '../crowd_action/crowd_action_browse.dart';
import '../crowd_action/crowd_action_details.dart';
import '../home/home_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: CrowdActionBrowsePage),
    AutoRoute(page: CrowdActionDetailsPage),
  ],
)
class $AppRouter {}
