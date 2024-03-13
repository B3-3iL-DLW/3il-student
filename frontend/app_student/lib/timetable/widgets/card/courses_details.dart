import 'package:app_student/timetable/widgets/card/courses_cours.dart';
import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetails({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF005067);
    const cardColor = Color.fromARGB(255, 144, 205, 255);

    return Card(
      color: cardColor,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: borderColor,
              width: 10.0,
            ),
          ),
        ),
        width: 300,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 45.0),
              CourseCours(course: course),
              const SizedBox(height: 10.0),
              Text(course['salle']),
            ],
          ),
        ),
      ),
    );
  }
}
