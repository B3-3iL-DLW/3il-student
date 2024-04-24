import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget implements PreferredSizeWidget {
  final double appBarHeight;
  final bool showBackButton;

  const HeaderLogo({super.key, required this.appBarHeight, this.showBackButton = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomTheme.primaryColor,
      leading: showBackButton ? IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ) : null,
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