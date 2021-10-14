import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';
import '../routes/app_routes.gr.dart';
import 'demo_tab_page.dart';
import 'home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    showOnboarding();
  }

  int index = 0;
  Widget? pageToShow;
  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      pageToShow = const HomePageScreen();
    } else if (index == 1) {
      pageToShow = const DemoTabPage();
    } else if (index == 2) {
      pageToShow = const DemoTabPage();
    }
    return Scaffold(
      floatingActionButton: !kReleaseMode
          ? FloatingActionButton(
              onPressed: () => context.router.push(DemoRoute()),
              backgroundColor: Colors.black,
              elevation: 10.0,
              child: const Icon(Icons.assignment),
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0),
          child: pageToShow,
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BottomNavigationBar(
            currentIndex: index,
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: const Color(0xFF2EB494),
            unselectedItemColor: const Color(0xFF333333),
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              if (value != index) {
                setState(() {
                  index = value;
                });
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/black_logo.png')),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_sharp),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_sharp),
                label: '',
              )
            ]),
      ),
    );
  }

  Future<void> showOnboarding() async {
    // Push onboarding screen if first time launching application
    final settingsRepository = getIt<ISettingsRepository>();
    if (!(await settingsRepository.getWasUserOnboarded())) {
      await settingsRepository.setWasUserOnboarded(true);
      context.router.push(const OnboardingRoute());
    }
  }
}
