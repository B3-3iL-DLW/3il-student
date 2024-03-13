import 'package:app_student/timetable/repository_test.dart';
import 'package:flutter/material.dart';
import 'package:app_student/timetable/widgets/header/header_logo.dart';
import 'package:app_student/classes/widgets/header/header_text.dart';
import 'package:app_student/timetable/widgets/card/courses_card.dart';

class TimeTableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const HeaderLogo(),
          const HeaderText("Date du jour"),
          ...course.map((course) => CourseCard(course: course)),
        ],
      ),
    );
  }
}
