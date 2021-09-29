import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../../domain/i_settings_repository.dart';
import '../../infrastructure/core/injection.dart';
import '../routes/app_routes.gr.dart';
import '../shared_widgets/menu_drawer.dart';
import '../themes/constants.dart';
import 'widgets/crowdaction_carousel.dart';

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

  @override
  Widget build(BuildContext context) {
    final _advancedDrawerController = AdvancedDrawerController();

    return MenuDrawer(
      advancedDrawerController: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: IconButton(
              icon: const Image(
                  image: AssetImage('assets/images/icons/menu_icon.png')),
              onPressed: () => _advancedDrawerController.showDrawer(),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23.0),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Upcoming crowdactions',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18.0),
                            ),
                            TextButton(
                              onPressed: () => context.router
                                  .push(const CrowdActionBrowseRoute()),
                              child: const Text(
                                'View all',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    color: kIrisColor),
                              ),
                            ),
                          ],
                        ),
                        const CrowdActionCarousel(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
