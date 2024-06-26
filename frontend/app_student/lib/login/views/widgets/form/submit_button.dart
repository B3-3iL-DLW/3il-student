import 'package:app_student/login/cubit/login_cubit.dart';
import 'package:app_student/utils/custom_button.dart';
import 'package:app_student/utils/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../users/cubit/user_cubit.dart';

class SubmitButton extends StatelessWidget {
  final TextEditingController nameController;

  const SubmitButton({
    super.key,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: AppLocalizations.of(context)!.loginButton,
      onPressed: () async {
        final String name = nameController.text.trim();
        final loginCubit = context.read<LoginCubit>();
        final userCubit = context.read<UserCubit>();

        await loginCubit.saveLoginDetails(name);
        await userCubit.fetchUser();

        if (userCubit.state is UserWithoutClass && context.mounted) {
          GoRouter.of(context).push('/classList');
        }
      },
      backgroundColor: CustomTheme.secondaryColor,
      textColor: Colors.white,
    );
  }
}
