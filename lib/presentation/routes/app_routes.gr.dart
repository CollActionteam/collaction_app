// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'dart:async' as _i9;

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../../domain/user/i_user_repository.dart' as _i7;
import '../authentication/register_phone_number_screen.dart' as _i6;
import '../authentication/verify_code_screen.dart' as _i8;
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
        }),
    RegisterPhoneNumberRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i6.RegisterPhoneNumberPage();
        }),
    VerifyCodeRoute.name: (routeData) => _i1.MaterialPageX<_i7.SignInResult>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<VerifyCodeRouteArgs>();
          return _i8.VerifyCodePage(
              credentialStream: args.credentialStream, key: args.key);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(CrowdActionBrowseRoute.name,
            path: '/crowd-action-browse-page'),
        _i1.RouteConfig(ContactFormRoute.name, path: '/contact-form-page'),
        _i1.RouteConfig(RegisterPhoneNumberRoute.name,
            path: '/register-phone-number-page'),
        _i1.RouteConfig(VerifyCodeRoute.name, path: '/verify-code-page')
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

class RegisterPhoneNumberRoute extends _i1.PageRouteInfo {
  const RegisterPhoneNumberRoute()
      : super(name, path: '/register-phone-number-page');

  static const String name = 'RegisterPhoneNumberRoute';
}

class VerifyCodeRoute extends _i1.PageRouteInfo<VerifyCodeRouteArgs> {
  VerifyCodeRoute(
      {required _i9.Stream<_i7.Credential> credentialStream, _i2.Key? key})
      : super(name,
            path: '/verify-code-page',
            args: VerifyCodeRouteArgs(
                credentialStream: credentialStream, key: key));

  static const String name = 'VerifyCodeRoute';
}

class VerifyCodeRouteArgs {
  const VerifyCodeRouteArgs({required this.credentialStream, this.key});

  final _i9.Stream<_i7.Credential> credentialStream;

  final _i2.Key? key;
}
