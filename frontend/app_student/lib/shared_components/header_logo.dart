import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight;

  const HeaderLogo({super.key, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomTheme.primaryColor,
      flexibleSpace: Center(
        child: SizedBox(
          width: 200.0,
          height: 200.0,
          child: Image.asset('assets/images/3il-logo.jpg'),
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(appBarHeight);
  }
}
