import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class HeaderTitle extends StatelessWidget {
  final String content;

  const HeaderTitle(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0, left: 25.0, bottom: 40),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          content,
          style: CustomTheme.title.toBold,
        ),
      ),
    );
  }
}
