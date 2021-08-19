// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../contact_form/contact_form_screen.dart' as _i5;
import '../crowd_action/crowd_action_browse.dart' as _i4;
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
    ContactFormRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i5.ContactFormPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(CrowdActionBrowseRoute.name,
            path: '/crowd-action-browse-page'),
        _i1.RouteConfig(ContactFormRoute.name, path: '/contact-form-page')
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

class ContactFormRoute extends _i1.PageRouteInfo {
  const ContactFormRoute() : super(name, path: '/contact-form-page');

  static const String name = 'ContactFormRoute';
}
