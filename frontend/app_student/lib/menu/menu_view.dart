import 'package:app_student/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'menu_item.dart';

class MenuBarView extends StatefulWidget {
  const MenuBarView({super.key});

  @override
  State<MenuBarView> createState() => MenuBarViewState();
}

class MenuBarViewState extends State<MenuBarView> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _setSelectedIndex();
  }

  void _setSelectedIndex() {
    final route = GoRouter.of(context).routeInformationProvider.value.uri.path;

    if (route == AppRoutes.loginPage) {
      _selectedIndex = 0;
    } else if (route == AppRoutes.schedulePage) {
      _selectedIndex = 1;
    } else if (route == AppRoutes.profilPage) {
      _selectedIndex = 2;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        GoRouter.of(context).go(AppRoutes.loginPage);
        break;
      case 1:
        GoRouter.of(context).go(AppRoutes.schedulePage);
        break;
      case 2:
        GoRouter.of(context).go(AppRoutes.profilPage);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        MenuIcon(
          iconPath: 'assets/images/disconnect.svg',
          selectedIndex: _selectedIndex,
          itemIndex: 0,
        ),
        MenuIcon(
          iconPath: 'assets/images/calendar.svg',
          selectedIndex: _selectedIndex,
          itemIndex: 1,
        ),
        MenuIcon(
          iconPath: 'assets/images/profil.svg',
          selectedIndex: _selectedIndex,
          itemIndex: 2,
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
