// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../models/crowd_action_model.dart' as _i6;
import '../crowd_action/crowd_action_browse.dart' as _i4;
import '../crowd_action/crowd_action_details.dart' as _i5;
import '../home/home_screen.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomePage();
        }),
    CrowdActionBrowseRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i4.CrowdActionBrowsePage();
        }),
    CrowdActionDetailsRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<CrowdActionDetailsRouteArgs>();
          return _i5.CrowdActionDetailsPage(key: args.key, model: args.model);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(CrowdActionBrowseRoute.name,
            path: '/crowd-action-browse-page'),
        _i1.RouteConfig(CrowdActionDetailsRoute.name,
            path: '/crowd-action-details-page')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class CrowdActionBrowseRoute extends _i1.PageRouteInfo {
  const CrowdActionBrowseRoute()
      : super(name, path: '/crowd-action-browse-page');

  static const String name = 'CrowdActionBrowseRoute';
}

class CrowdActionDetailsRoute
    extends _i1.PageRouteInfo<CrowdActionDetailsRouteArgs> {
  CrowdActionDetailsRoute({_i2.Key? key, required _i6.CrowdActionModel model})
      : super(name,
            path: '/crowd-action-details-page',
            args: CrowdActionDetailsRouteArgs(key: key, model: model));

  static const String name = 'CrowdActionDetailsRoute';
}

class CrowdActionDetailsRouteArgs {
  const CrowdActionDetailsRouteArgs({this.key, required this.model});

  final _i2.Key? key;

  final _i6.CrowdActionModel model;
}
