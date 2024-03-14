import 'package:flutter/cupertino.dart';

class HeaderTitle extends StatelessWidget {
  final String content;

  const HeaderTitle(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 25.0, bottom: 2),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          content,
          style: const TextStyle(
            fontSize: 34.0,
            fontFamily: 'Arial',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
