// TODO delete after MVP phase!

import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';

Future<bool> checkAndMaybeShowCaptivePage(
  StackRouter router,
) async {
  if (DateTime.now().isAfter(DateTime.parse('2022-01-31'))) {
    if (!router.isRouteActive(const CaptiveRoute().routeName)) {
      await router.popAndPush(const CaptiveRoute());
      return true;
    }
  }
  return false;
}
