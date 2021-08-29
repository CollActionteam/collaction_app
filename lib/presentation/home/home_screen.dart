import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../routes/app_routes.gr.dart';
import '../themes/constants.dart';
import 'widgets/crowdaction_carousel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _advancedDrawerController = AdvancedDrawerController();

    return AdvancedDrawer(
      backdropColor: Colors.white,
      controller: _advancedDrawerController,
      drawer: ListTileTheme(
        textColor: Colors.black,
        iconColor: Colors.black,
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group_add, size: 27),
              title: Text('Invite friends'),
            ),
            Divider(
              color: Colors.black38,
              height: 1,
            ),
            ListTile(
              leading: ImageIcon(
                AssetImage('assets/images/icons/browse.png'),
                size: 24,
              ),
              title: Text('Browse'),
            ),
            ListTile(
              leading: ImageIcon(
                AssetImage('assets/images/icons/check.png'),
                size: 24,
              ),
              title: Text('My Crowdactions'),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
                maxRadius: 15,
              ),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.mail_outline_outlined, size: 27),
              title: Text('Contact Us'),
            ),
          ],
        ),
      ),
      child: Scaffold(
        // drawerScrimColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.format_align_left,
              color: Colors.black54,
            ),
            onPressed: () {
              _advancedDrawerController.showDrawer();
            },
          ),
        ),

        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 23.0, horizontal: 23.0),
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
                          onPressed: () {
                            context.router.push(const ContactFormRoute());
                          },
                          child:
                              const Text('Give feedback or start crowd action'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.router.push(const ComponentsDemoRoute());
                          },
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
