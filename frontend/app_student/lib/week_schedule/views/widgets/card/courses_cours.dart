import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CourseCours extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCours({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(course['cours']),
        const Expanded(child: SizedBox.shrink()),
        SvgPicture.asset(
          'assets/images/microsoft-teams.svg',
          width: 30,
          height: 30,
          color: Colors.white,
        ),
      ],
    );
  }
}
