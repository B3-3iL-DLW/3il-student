import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF005067),
      toolbarHeight: 70.0,
      title: Opacity(
        opacity: 0.5,
        child: Image.asset(
          'assets/images/3il-icon-white.png',
          fit: BoxFit.contain,
        ),
      ),
      centerTitle: true,
    );
  }
}
