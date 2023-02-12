import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../presentation/themes/constants.dart';
import '../../domain/core/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAndMaybeShowOnboarding();
    });
  }

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

  Future<void> checkAndMaybeShowOnboarding() async {
    // Push onboarding screen if first time launching application
    final settingsRepository = getIt<ISettingsRepository>();
    if (!(await settingsRepository.getWasUserOnboarded())) {
      context.router.push(const OnboardingRoute());
    }
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
      items:  [
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
          icon: Icon(Icons.grid_view,),
          label: '',
        ),
      ],
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
    );
  }
}
