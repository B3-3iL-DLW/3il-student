import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/class_group_cubit.dart';

class CardList extends StatelessWidget {
  final List<ClassGroupModel> classesList;

  const CardList({super.key, required this.classesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classesList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
          child: ListTile(
            title: Text(
              classesList[index].name,
            ),
            onTap: () {
              context.read<ClassGroupCubit>().saveClass(classesList[index]);
            },
          ),
        );
      },
    );
  }
}
