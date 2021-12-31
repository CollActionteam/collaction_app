import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../presentation/themes/constants.dart';
import '../../domain/core/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';
import '../core/collaction_icons.dart';
import '../routes/app_routes.gr.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => checkAndMaybeShowCaptivePage());
  }

  Future<void> checkAndMaybeShowCaptivePage() async {
    if (DateTime.now().isAfter(DateTime.parse('2021-01-31'))) {
      context.router.popAndPush(const CaptiveRoute());
    } else {
      showOnboarding();
    }
  }

  Future<void> showOnboarding() async {
    // Push onboarding screen if first time launching application
    final settingsRepository = getIt<ISettingsRepository>();
    if (!(await settingsRepository.getWasUserOnboarded())) {
      await settingsRepository.setWasUserOnboarded(wasOnboarded: true);
      context.router.push(const AuthRoute());
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CollactionIcons.collaction),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CollactionIcons.user),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.assignment_outlined,
          ),
          label: '',
        )
      ],
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        CrowdactionRouter(),
        UserProfileRouter(),
        DemoScreenRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => bottomNavbar(tabsRouter),
    );
  }
}
