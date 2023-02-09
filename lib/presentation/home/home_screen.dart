import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../presentation/themes/constants.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.gr.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        CrowdactionRouter(),
        UserProfileRouter(),
        if (!kReleaseMode) ...[
          DemoScreenRouter(),
        ],
        MenuScreenRouter()
      ],
      bottomNavigationBuilder: (_, tabsRouter) => bottomNavbar(tabsRouter),
    );
  }

  Widget bottomNavbar(TabsRouter tabsRouter) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: kEnabledButtonColor,
      unselectedItemColor: kDisabledButtonColor,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CollactionIcons.collaction),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CollactionIcons.user),
          label: '',
        ),
        if (!kReleaseMode) ...[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_outlined,
            ),
            label: '',
          ),
        ],
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_outlined),
          label: '',
        ),
      ],
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
    );
  }
}
