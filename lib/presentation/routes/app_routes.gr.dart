// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../components_demo/components_demo_screen.dart' as _i6;
import '../contact_form/contact_form_screen.dart' as _i5;
import '../crowd_action/crowd_action_browse.dart' as _i4;
import '../home/home_screen.dart' as _i3;
import '../onboarding/onboarding.dart' as _i7;

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
        }),
    ComponentsDemoRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.ComponentsDemoPage();
        }),
    OnboardingRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i7.OnboardingPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/home-page'),
        _i1.RouteConfig(CrowdActionBrowseRoute.name,
            path: '/crowd-action-browse-page'),
        _i1.RouteConfig(ContactFormRoute.name, path: '/contact-form-page'),
        _i1.RouteConfig(ComponentsDemoRoute.name,
            path: '/components-demo-page'),
        _i1.RouteConfig(OnboardingRoute.name, path: '/')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home-page');

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

class ComponentsDemoRoute extends _i1.PageRouteInfo {
  const ComponentsDemoRoute() : super(name, path: '/components-demo-page');

  static const String name = 'ComponentsDemoRoute';
}

class OnboardingRoute extends _i1.PageRouteInfo {
  const OnboardingRoute() : super(name, path: '/');

  static const String name = 'OnboardingRoute';
}
