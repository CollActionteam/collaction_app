import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/collaction_icons.dart';
import '../core/routes/app_page.dart';
import '../themes/constants.dart';

part 'widgets/home_nav.dart';

class HomePage extends StatelessWidget {
  // Current display page
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: bottomNavbar(context),
    );
  }
}
