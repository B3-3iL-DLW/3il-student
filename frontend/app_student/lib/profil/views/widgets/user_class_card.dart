import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserClassCard extends StatelessWidget {
  final String className;
  final String firstName;
  final VoidCallback onTap;

  const UserClassCard({
    required this.className,
    required this.firstName,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: ListTile(
            leading: SizedBox(
              width: 50,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                    CustomTheme.primaryColor, BlendMode.srcIn),
                child: SvgPicture.asset(
                  'assets/images/user.svg',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            title: Text(className, style: CustomTheme.textXl),
            subtitle: Text(firstName, style: CustomTheme.text),
          ),
        ),
      ),
    );
  }
}
