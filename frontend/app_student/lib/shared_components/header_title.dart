import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  final String content;

  const HeaderTitle(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0, top: 35.0),
          child: Text(
            content,
            style: CustomTheme.title.toBold,
          ),
        ),
      ],
    );
  }
}
