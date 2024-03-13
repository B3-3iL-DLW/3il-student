import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:app_student/class_groups/views/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app_student/class_groups/views/widgets/header/header_logo.dart';
import 'package:app_student/class_groups/views/widgets/header/header_text.dart';
import 'package:app_student/class_groups/views/widgets/header/header_title.dart';

class ClassListPage extends StatelessWidget {
  const ClassListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final classRepository =
        RepositoryProvider.of<ClassGroupRepository>(context);
    final classCubit = ClassGroupCubit(classRepository: classRepository);

    return BlocProvider<ClassGroupCubit>(
      create: (context) => classCubit..fetchClasses(),
      child: Scaffold(
        body: BlocBuilder<ClassGroupCubit, ClassGroupState>(
          builder: (context, state) {
            if (state is ClassGroupLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ClassGroupLoaded) {
              return Column(
                children: [
                  const HeaderLogo(),
                  const HeaderTitle('Bonjour, ####'),
                  const HeaderText('Dans quelle classe êtes-vous ?'),
                  Expanded(
                    child: CardList(classesList: state.classes),
                  ),
                ],
              );
            } else if (state is ClassGroupError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
