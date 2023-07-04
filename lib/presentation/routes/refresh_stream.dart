import 'dart:async';

import 'package:flutter/material.dart';

import '../../application/auth/auth_bloc.dart';

class GoRouterAuthRefreshStream extends ChangeNotifier {
  late final StreamSubscription<AuthState> _subscription;

  GoRouterAuthRefreshStream(Stream<AuthState> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((state) {
      // Only notify router to rebuild on following conditions
      state.maybeWhen(
          authenticated: (_) => notifyListeners(),
          loggedIn: (_) => notifyListeners(),
          unauthenticated: () => notifyListeners(),
          orElse: () {});
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
