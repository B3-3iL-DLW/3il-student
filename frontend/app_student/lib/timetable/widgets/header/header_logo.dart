import 'package:flutter/cupertino.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0, // Réduisez la hauteur du Container
      color: const Color(0xFF005067),
      child: Align(
        alignment: Alignment.centerLeft, // Alignez à gauche
        child: Padding(
          padding:
              const EdgeInsets.all(8.0), // Ajoutez une marge autour du logo
          child: SizedBox(
            width: 100.0, // Réduisez la largeur de l'image
            height: 100.0, // Réduisez la hauteur de l'image
            child: Image.asset('assets/images/3il-logo.jpg'),
          ),
        ),
      ),
    );
  }
}
