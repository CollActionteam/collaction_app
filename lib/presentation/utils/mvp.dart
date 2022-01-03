// TODO delete after MVP phase!

import 'dart:async';
import 'dart:core';

import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';

Future<void> checkAndMaybeShowCaptivePage(StackRouter router,
    {Timer? timer}) async {
  if (DateTime.now().isAfter(DateTime.parse('2022-01-31'))) {
    timer?.cancel();
    if (!router.isRouteActive(const CaptiveRoute().routeName)) {
      await router.popAndPush(const CaptiveRoute());
    }
  }
}
