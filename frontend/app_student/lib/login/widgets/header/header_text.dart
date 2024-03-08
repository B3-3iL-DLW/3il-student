import 'package:flutter/cupertino.dart';

class HeaderText extends StatelessWidget {
  final String content;

  const HeaderText(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 35.0,
          left: 25.0,
          bottom: 40), // Ajout d'un espacement à gauche de 10px
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 32.0,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
