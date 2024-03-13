import 'package:flutter/cupertino.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210.0, // Hauteur du Container
      color: const Color(0xFF005067),
      child: Center(
        child: SizedBox(
          width: 200.0, // Largeur de l'image
          height: 200.0, // Hauteur de l'image
          child: Image.asset('assets/images/3il-logo.jpg'),
        ),
      ),
    );
  }
}
