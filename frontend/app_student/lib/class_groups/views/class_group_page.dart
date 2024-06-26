import 'package:app_student/class_groups/cubit/class_group_cubit.dart';
import 'package:app_student/class_groups/views/widgets/card_list.dart';
import 'package:app_student/users/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          if (userState is UserInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (userState is UserError) {
            return const NetworkError();
          } else if (userState is UserLoggedIn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/school_space');
            });
            return const Center(child: CircularProgressIndicator());
          } else if (userState is UserWihtoutLink) {
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Fluttertoast.showToast(
                      msg: AppLocalizations.of(context)!
                          .errors_code(classState.message),
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      textColor: Colors.white,
                    );
                  });
                  return const SizedBox.shrink();
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
