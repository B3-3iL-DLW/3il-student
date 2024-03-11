import 'package:app_student/timetable/repository_test.dart';
import 'package:flutter/material.dart';
import 'package:app_student/timetable/widgets/header/header_logo.dart';
import 'package:app_student/classes/widgets/header/header_text.dart';

class TimeTableView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HeaderLogo(),
          HeaderText("Date du jour"),
          ...course.map((course) {
            return Center(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(course['horaire-debut']),
                        Text(course['horaire-fin']),
                      ],
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 300,
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(course['cours']),
                          Text(course['salle']),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
