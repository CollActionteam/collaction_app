import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../routes/app_routes.gr.dart';

class UnauthenticatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () => context.router.push(const AuthRoute()),
            child: Text("You need to be authenticated to enter the app.\nLogin")),
      ),
    );
  }

}