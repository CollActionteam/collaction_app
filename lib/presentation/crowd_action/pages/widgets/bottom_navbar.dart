import 'package:auto_route/auto_route.dart';
import 'package:collaction_app/presentation/routes/app_routes.gr.dart';

import 'package:collaction_app/presentation/themes/constants.dart';
import 'package:flutter/material.dart';

class TestBottomNavbar extends StatefulWidget {
  const TestBottomNavbar({Key? key}) : super(key: key);

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<TestBottomNavbar> {
  late int index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
  }

  void onTapHandler(int index) {
    if (index == 0) {
      // context.router.push(HomeRoute());
      context.router.popUntilRouteWithName('HomeRoute');
      // context.router.navigate(HomeRoute());
      // context.router.popUntilRoot();
    } else if (index == 1) {
      context.router.navigate(DemoRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: kEnabledButtonColor,
      unselectedItemColor: kDisabledButtonColor,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        if (value != index) {
          setState(() {
            index = value;
            onTapHandler(index);
          });
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/black_logo.png')),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/icons/person.png')),
          label: '',
        ),
      ],
    );
  }
}
