import 'package:flutter/material.dart';

class CourseTime extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseTime({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(course['horaire-debut']),
          Text(course['horaire-fin']),
        ],
      ),
    );
  }
}
