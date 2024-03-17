import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/cupertino.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      color: CustomTheme.primaryColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: SizedBox(
            width: 200.0,
            height: 200.0,
            child: Image.asset('assets/images/3il-logo.jpg'),
          ),
        ),
      ),
    );
  }
}
