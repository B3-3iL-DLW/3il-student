import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/custom_theme.dart';

class MenuIcon extends BottomNavigationBarItem {
  MenuIcon({
    required String iconPath,
    required int selectedIndex,
    required int itemIndex,
    required String label,
  }) : super(
          icon: SvgPicture.asset(
            iconPath,
            height: 20,
            width: 20,
            colorFilter: selectedIndex == itemIndex
                ? const ColorFilter.mode(
                    CustomTheme.secondaryColor, BlendMode.srcIn)
                : const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
          ),
          label: label,
        );
}
