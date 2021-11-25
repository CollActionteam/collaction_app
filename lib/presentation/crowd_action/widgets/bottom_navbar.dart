import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: BottomNavigationBar(
        // currentIndex: index,
        backgroundColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF2EB494),
        unselectedItemColor: const Color(0xFF333333),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/black_logo.png')),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/images/icons/person.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_sharp),
            label: '',
          )
        ],
      ),
    );
  }
}