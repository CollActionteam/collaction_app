import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockGoRouterProvider extends StatelessWidget {
  const MockGoRouterProvider({
    required this.goRouter,
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The mock navigator used to mock navigation calls.
  final GoRouter goRouter;

  /// The child [Widget] to render.
  final Widget child;

  @override
  Widget build(BuildContext context) => InheritedGoRouter(
        goRouter: goRouter,
        child: child,
      );
}

extension RouterX on Widget {
  /// Returns [this] wrapped in a [MockGoRouterProvider]
  /// if [router] is not null.
  /// Otherwise returns [this].
  ///
  /// Use this when verifying navigation is required in a test case.
  ///
  /// ```
  /// MaterialApp(
  ///   home: Scaffold(
  ///     body: WidgetToPump(),
  ///   ),
  /// ).withRouterScope(goRouter);
  /// ```
  Widget withRouterScope(GoRouter? router) {
    return router != null
        ? MockGoRouterProvider(
            goRouter: router,
            child: this,
          )
        : this;
  }
}

/// Route Helpers
class RouteHelpers {
  /// Sets up default routing stubs
  static GoRouter setUpRouterStubs() {
    final GoRouter goRouter = MockGoRouter();
    when(() => goRouter.push(any())).thenAnswer((_) async => null);
    when(() => goRouter.push(any(), extra: any(named: 'extra')))
        .thenAnswer((_) async => null);
    when(() => goRouter.replace(any())).thenAnswer((_) async {});
    when(() => goRouter.replaceNamed(any())).thenAnswer((_) async {});
    when(() => goRouter.pop()).thenAnswer((_) async => true);

    return goRouter;
  }
}
