import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class HeaderSubtitle extends StatelessWidget {
  final String content;

  const HeaderSubtitle(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 20.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          content,
          style: CustomTheme.subtitle.toBold,
        ),
      ),
    );
  }
}
