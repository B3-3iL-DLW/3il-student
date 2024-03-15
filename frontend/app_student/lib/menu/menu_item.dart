import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuIcon extends BottomNavigationBarItem {
  MenuIcon({
    required String iconPath,
    required int selectedIndex,
    required int itemIndex,
  }) : super(
    icon: SvgPicture.asset(
      iconPath,
      height: 20,
      width: 20,
      colorFilter: selectedIndex == itemIndex
          ? const ColorFilter.mode(Colors.blue, BlendMode.srcIn)
          : null,
    ),
    label: '',
  );
}