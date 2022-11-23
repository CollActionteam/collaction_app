import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:mocktail/mocktail.dart';

class MockStackRouter extends Mock implements StackRouter {}

class MockNavigationResolver extends Mock implements NavigationResolver {}

// ignore: avoid_implementing_value_types
class FakePageRouteInfo extends Fake implements PageRouteInfo {}

extension StackRouterX on Widget {
  /// Returns [this] wrapped in a [StackRouterScope]
  /// if [stackRouter] is not null.
  /// Otherwise returns [this].
  ///
  /// Use this when verifying navigation is required in a test case.
  ///
  /// ```
  /// MaterialApp(
  ///   home: Scaffold(
  ///     body: WidgetToPump(),
  ///   ),
  /// ).withRouterScope(stackRouter);
  /// ```
  Widget withRouterScope(StackRouter? stackRouter) {
    return stackRouter != null
        ? StackRouterScope(
            controller: stackRouter,
            stateHash: 0,
            child: this,
          )
        : this;
  }
}

/// Route Helpers
class RouteHelpers {
  /// Sets up default routing stubs
  static StackRouter setUpRouterStubs() {
    registerFallbackValue(FakePageRouteInfo());

    final StackRouter stackRouter = MockStackRouter();
    when(() => stackRouter.push(any())).thenAnswer((_) async => null);
    when(() => stackRouter.replaceNamed(any())).thenAnswer((_) async => null);

    return stackRouter;
  }
}
