import 'package:flutter/material.dart';
import 'courses_details.dart';
import 'courses_time.dart';

class CourseCard extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          CourseTime(course: course),
          CourseDetails(course: course),
        ],
      ),
    );
  }
}
