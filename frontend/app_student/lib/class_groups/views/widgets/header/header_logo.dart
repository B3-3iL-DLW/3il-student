import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          'assets/images/3il-logo.jpg',
          fit: BoxFit.contain,
          height: 32,
        ),
      ],
    );
  }
}
