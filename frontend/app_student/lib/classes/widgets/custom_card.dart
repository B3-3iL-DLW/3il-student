import 'package:app_student/api/classes/entities/class.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final List<Class> classesList;

  CustomCard({required this.classesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classesList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              classesList[index].name,
            ),
          ),
        );
      },
    );
  }
}
