import 'package:app_student/api/class_groups/models/class_group_model.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardList extends StatelessWidget {
  final List<ClassGroupModel> classesList;

  const CardList({super.key, required this.classesList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: classesList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(top: 10.0),
          child: ListTile(
            title: Text(
              classesList[index].name,
            ),
            onTap: () {
              context.read<UserCubit>().saveUserClass(classesList[index]);
            },
          ),
        );
      },
    );
  }
}
