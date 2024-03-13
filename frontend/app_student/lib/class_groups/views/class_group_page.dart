import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:app_student/class_groups/views/widgets/card_list.dart';
import 'package:app_student/class_groups/views/widgets/header/header_logo.dart';
import 'package:app_student/class_groups/views/widgets/header/header_text.dart';
import 'package:app_student/class_groups/views/widgets/header/header_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../api/users/models/user_model.dart';
import '../../api/users/repositories/user_repository.dart';

class ClassGroupPage extends StatelessWidget {
  const ClassGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final classRepository =
        RepositoryProvider.of<ClassGroupRepository>(context);
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    final classCubit = ClassGroupCubit(
        classRepository: classRepository, userRepository: userRepository);

    return BlocProvider<ClassGroupCubit>(
      create: (context) => classCubit..fetchClasses(),
      child: FutureBuilder<UserModel>(
        future: context.read<ClassGroupCubit>().getConnectedUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final user = snapshot.data;
            return Scaffold(
              body: BlocBuilder<ClassGroupCubit, ClassGroupState>(
                builder: (context, state) {
                  if (state is ClassGroupLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ClassGroupSelected) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/schedule');
                    });
                    return const SizedBox.shrink();
                  } else if (state is ClassGroupLoaded) {
                    return Column(
                      children: [
                        const HeaderLogo(),
                        HeaderTitle('Bonjour, ${user?.name}'),
                        const HeaderText('Choisis ta promotion :'),
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
            );
          }
        },
      ),
    );
  }
}
