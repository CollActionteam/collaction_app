import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../routes/app_routes.gr.dart';
import '../shared_widgets/menu_drawer.dart';
import '../themes/constants.dart';
import 'widgets/crowdaction_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _advancedDrawerController = AdvancedDrawerController();

    return MenuDrawer(
      advancedDrawerController: _advancedDrawerController,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.format_align_left,
              color: Colors.black54,
            ),
            onPressed: () => _advancedDrawerController.showDrawer(),
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
                        ElevatedButton(
                          onPressed: () =>
                              context.router.push(const ContactFormRoute()),
                          child:
                              const Text('Give feedback or start crowd action'),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              context.router.push(const ComponentsDemoRoute()),
                          child: const Text('UI Components Demo Page'),
                        ),
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
}
