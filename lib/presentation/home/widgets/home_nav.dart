part of '../home_screen.dart';

/// Home page navigation bar
Widget bottomNavbar(BuildContext context) {
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
    ],
    currentIndex: _selectedIndex(context),
    onTap: (index) => _onItemTapped(index, context),
  );
}

int _selectedIndex(BuildContext context) {
  final GoRouter route = GoRouter.of(context);
  final String location = route.location;

  if (location == AppPage.home.toPath) {
    return 0;
  }

  if (location == AppPage.userProfile.toPath) {
    return 1;
  }

  if (!kReleaseMode && location == AppPage.demoPage.toPath) {
    return 2;
  }

  return 0;
}

void _onItemTapped(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.replace(AppPage.home.toPath);
      break;
    case 1:
      context.replace(AppPage.userProfile.toPath);
      break;
    case 2:
      context.replace(AppPage.demoPage.toPath);
      break;
  }
}
