import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserInfoCard extends StatelessWidget {
  final String ine;
  final String birthDate;

  const UserInfoCard({super.key, required this.ine, required this.birthDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Card(
        child: ListTile(
          leading: SizedBox(
            width: 50,
            child: ColorFiltered(
              colorFilter:
                  const ColorFilter.mode(Color(0xFF005067), BlendMode.srcIn),
              child: SvgPicture.asset(
                'assets/images/student-info.svg',
                width: 30,
                height: 30,
              ),
            ),
          ),
          title: Text(ine),
          subtitle: Text(birthDate),
        ),
      ),
    );
  }
}
