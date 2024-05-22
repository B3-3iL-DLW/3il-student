import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:app_student/class_groups/views/widgets/card_list.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../shared_components/app_bar.dart';
import '../../shared_components/header_subtitle.dart';
import '../../shared_components/header_title.dart';
import '../../shared_components/network_error.dart';
import '../../utils/custom_layout.dart';

class ClassGroupPage extends StatelessWidget {
  const ClassGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      appBar: const CustomAppBar(),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          print(userState);
          if (userState is UserClassesSelected) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/schedule');
            });
            return const Center(child: CircularProgressIndicator());
          } else if (userState is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (userState is UserWithoutClass) {
            final user = userState.user;
            return BlocBuilder<ClassGroupCubit, ClassGroupState>(
              builder: (context, classState) {
                if (classState is ClassGroupLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (classState is ClassGroupLoaded) {
                  return Column(
                    children: [
                      HeaderTitle(AppLocalizations.of(context)!
                          .classSelectionTitle(user.firstName!)),
                      HeaderSubtitle(
                          AppLocalizations.of(context)!.classSelectionSubtitle),
                      CardList(classesList: classState.classes),
                    ],
                  );
                } else if (classState is ClassGroupError) {
                  return const NetworkError();
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return const Text('error');
          }
        },
      ),
    );
  }
}
