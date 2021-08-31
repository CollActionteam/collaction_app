import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:share_plus/share_plus.dart';

import '../routes/app_routes.gr.dart';

class MenuDrawer extends StatelessWidget {
  final Widget child;
  const MenuDrawer(
      {Key? key,
      required AdvancedDrawerController advancedDrawerController,
      required this.child})
      : _advancedDrawerController = advancedDrawerController,
        super(key: key);

  final AdvancedDrawerController _advancedDrawerController;

  @override
  Widget build(BuildContext context) {
    final drawerItems = <Widget>[
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
        child: Text(
          'Menu',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
        ),
      ),
      ListTile(
        onTap: () =>
            // TODO Later this should be changed to something like collaction.org/app that will forward to the AppStore or PlayStore depending on the mobile device.
            Share.share(
                'Help me make the world a bit better on https://www.collaction.org/'),
        leading: const Icon(Icons.group_add, size: 27),
        title: const Text('Invite friends'),
      ),
      const Divider(
        color: Colors.black38,
        height: 1,
      ),
      ListTile(
        onTap: () => pushRoute(context, const CrowdActionBrowseRoute()),
        leading: const ImageIcon(
          AssetImage('assets/images/icons/browse.png'),
          size: 24,
        ),
        title: const Text('Browse'),
      ),
      ListTile(
        onTap: () {}, // TODO: Own crowdactions / participating in ...
        leading: const ImageIcon(
          AssetImage('assets/images/icons/check.png'),
          size: 24,
        ),
        title: const Text('My Crowdactions'),
      ),
      ListTile(
        onTap: () {}, // TODO: Add profile route
        leading: const CircleAvatar(
          backgroundColor: Colors.black,
          maxRadius: 15,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: const Text('Profile'),
      ),
      ListTile(
        onTap: () => pushRoute(context, const ContactFormRoute()),
        leading: const Icon(Icons.mail_outline_outlined, size: 27),
        title: const Text('Contact Us'),
      )
    ];

    if (!kReleaseMode) {
      // Demo content should not be visible in release builds
      drawerItems.add(ListTile(
        onTap: () => pushRoute(context, const DemoRoute()),
        leading: const Icon(Icons.list_alt, size: 27),
        title: const Text('Demo Content'),
      ));
    }

    return AdvancedDrawer(
      backdropColor: Colors.white,
      controller: _advancedDrawerController,
      drawer: ListTileTheme(
        textColor: Colors.black,
        iconColor: Colors.black,
        child: ListView(
          children: drawerItems,
        ),
      ),
      child: child,
    );
  }

  void pushRoute(BuildContext context, PageRouteInfo route) {
    _advancedDrawerController.showDrawer();
    context.router.push(route);
  }
}
