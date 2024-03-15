import 'package:app_student/api/class_groups/repositories/class_group_repository.dart';
import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:app_student/class_groups/views/widgets/card_list.dart';
import 'package:app_student/components/header_subtitle.dart';
import 'package:app_student/components/header_title.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../api/users/models/user_model.dart';
import '../../components/app_bar.dart';

class ClassGroupPage extends StatelessWidget {
  const ClassGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final classRepository =
        RepositoryProvider.of<ClassGroupRepository>(context);
    final classCubit = ClassGroupCubit(
      classRepository: classRepository,
    )..fetchClasses();

    return BlocProvider<ClassGroupCubit>(
      create: (context) => classCubit,
      child: FutureBuilder<UserModel>(
        future: context.read<UserCubit>().getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else {
            final user = snapshot.data;
            return Scaffold(
              appBar: const CustomAppBar(),
              body: BlocListener<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserClassesSelected) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.go('/schedule');
                    });
                  }
                },
                child: BlocBuilder<ClassGroupCubit, ClassGroupState>(
                  builder: (context, state) {
                    if (state is ClassGroupLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ClassGroupLoaded) {
                      return Column(
                        children: [
                          HeaderTitle(AppLocalizations.of(context)!
                              .classSelectionTitle(user!.name)),
                          HeaderSubtitle(AppLocalizations.of(context)!
                              .classSelectionSubtitle),
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
        },
      ),
    );
  }
}
