// TODO delete after MVP phase!

import 'dart:core';

import 'package:auto_route/auto_route.dart';

import '../routes/app_routes.gr.dart';

Future<bool> checkAndMaybeShowCaptivePage(
  StackRouter router,
) async {
  if (!DateTime.now().isBefore(DateTime.parse('2022-02-01'))) {
    if (!router.isRouteActive(const CaptiveRoute().routeName)) {
      await router.popAndPush(const CaptiveRoute());
      return true;
    }
  }
  return false;
}
