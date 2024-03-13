import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  final List<ClassGroupModel> classesList;

  const CardList({super.key, required this.classesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classesList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
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
