import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuBarView extends StatefulWidget {
  const MenuBarView({super.key});

  @override
  State<MenuBarView> createState() => MenuBarViewState();
}

class MenuBarViewState extends State<MenuBarView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/disconnect.svg',
              height: 20,
              width: 20,
              colorFilter: _selectedIndex == 0
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/calendar.svg',
              height: 20,
              width: 20,
              colorFilter: _selectedIndex == 1
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : null,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profil.svg',
              height: 20,
              width: 20,
              colorFilter: _selectedIndex == 2
                  ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
                  : null,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}